import 'dart:async';
import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:another_telephony/telephony.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

import '../../hive/hive_adapter.dart';
import '../../injection/injection.dart';
import '../../repository/settings/settings_repository.dart';
import '../../repository/user/user_repository.dart';
import '../base/base_provider.dart';

const _myHelper = 'myhelper';
const _contactCommand = 'get_contact';
const _soundCommand = 'ring';
const _locationCommand = 'get_location';
const _alarmCommand = 'alarm';

const _alarmId = 2500;

@lazySingleton
class PermissionProvider extends BaseProvider {
  final telephony = Telephony.instance;
  bool _hasSMSPermission = false;
  bool _hasContactPermission = false;
  bool _hasSoundProfilePermission = false;
  bool _hasLocationPermission = false;
  bool _hasLocationServicePermission = false;
  bool _hasAlarmPermission = false;

  bool get hasSMSPermission => _hasSMSPermission;

  bool get hasContactPermission => _hasContactPermission;

  bool get hasSoundProfilePermission => _hasSoundProfilePermission;

  bool get hasLocationPermission => _hasLocationPermission;

  bool get hasLocationServicePermission => _hasLocationServicePermission;

  bool get hasAlarmPermission => _hasAlarmPermission;

  bool get isAllAllowed =>
      hasSMSPermission &&
      hasContactPermission &&
      hasSoundProfilePermission &&
      hasLocationPermission &&
      hasLocationServicePermission &&
      hasAlarmPermission;

  bool get isAlarmRinging => _settingsRepository.settings.isAlarmRinging;

  final SettingsRepository _settingsRepository;

  PermissionProvider(this._settingsRepository);

  Future<void> initializePermissions() async {
    _hasSMSPermission = await Permission.sms.isGranted;
    _hasContactPermission = await Permission.contacts.isGranted;
    _hasSoundProfilePermission = await PermissionHandler.permissionsGranted ?? false;

    _hasLocationPermission = await Permission.locationAlways.isGranted;
    _hasLocationServicePermission = await Permission.locationAlways.serviceStatus.isEnabled;

    _hasAlarmPermission = await Permission.scheduleExactAlarm.isGranted;

    await _setupSMS();
    notifyListeners();
  }

  Future<void> setupSMSPermission() async {
    _hasSMSPermission = await telephony.requestPhoneAndSmsPermissions ?? false;
    await _setupSMS();
    notifyListeners();
  }

  Future<void> setupContactPermission() async {
    _hasContactPermission = await Permission.contacts.request().isGranted;
    await _setupSMS();
    notifyListeners();
  }

  Future<void> setupSoundProfilePermission() async {
    await PermissionHandler.openDoNotDisturbSetting();
    notifyListeners();
  }

  Future<void> setupLocationPermission() async {
    await openAppSettings();
    notifyListeners();
  }

  Future<void> setupLocationServicePermission() async {
    await Location().requestService();
    notifyListeners();
  }

  Future<void> setupAlarmPermission() async {
    _hasAlarmPermission = await Permission.scheduleExactAlarm.request().isGranted;
    await _setupSMS();
    notifyListeners();
  }

  Future<void> stopAlarm() async {
    await _settingsRepository.saveAlarm(isAlarmRinging: false);
    await Alarm.stop(_alarmId);
    setViewIdeal();
  }

  Future<void> _setupSMS() async {
    if (!isAllAllowed) {
      return;
    }

    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) async {
        log(message.address.toString());

        final response = await _getResponse(message.body);

        if (response == null) {
          return;
        }

        await telephony.sendSms(
          to: message.address ?? '',
          message: 'Message from foreground, $response',
        );
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }
}

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(SmsMessage message) async {
  await Hive.initFlutter();
  HiveAdapter.register();
  await configureInjection();
  log(message.address.toString());

  final response = await _getResponse(message.body);

  if (response == null) {
    return;
  }

  unawaited(
    Telephony.backgroundInstance.sendSms(
      to: message.address ?? '',
      message: 'Message from Background, $response',
    ),
  );
}

Future<String?> _getResponse(String? body) async {
  final command = _extractCommand(body);

  log(command.toString(), name: 'Command');

  switch (command) {
    case _contactCommand:
      final contactName = _extractContactName(body);
      log(contactName.toString());
      if (contactName == null) {
        return null;
      }
      return _getContact(contactName);

    case _soundCommand:
      final isUpdated = await _changeSoundProfile();

      return isUpdated ? 'Changed Profile to Ring Mode' : 'Failed to change';
    case _locationCommand:
      return _getCurrentLocation();
    case _alarmCommand:
      return _setAlarm();
  }

  return null;
}

Future<String?> _getContact(String name) async {
  try {
    final List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);

    Contact? contact;
    for (final element in contacts) {
      if (element.displayName == name) {
        contact = element;
      }
    }

    final contactList = contact?.phones.map((e) => e.number.toString()).join(
              ', ',
            ) ??
        'Not Found';

    return "Contact for '$name' - $contactList";
  } catch (e) {
    log(e.toString(), name: 'Error');
  }

  return 'Permission Denied';
}

Future<bool> _changeSoundProfile() async {
  try {
    await SoundMode.setSoundMode(RingerModeStatus.normal);
    return true;
  } catch (e) {
    log(e.toString(), name: 'Error');
  }
  return false;
}

Future<String?> _getCurrentLocation() async {
  try {
    final locationData = await Location().getLocation();
    return 'Current location: ${locationData.latitude},${locationData.longitude}';
  } catch (e) {
    log(e.toString(), name: 'Error');
  }
  return 'Permission Denied';
}

Future<String> _setAlarm() async {
  try {
    await Alarm.init();

    await locator<SettingsRepository>().saveAlarm(isAlarmRinging: true);
    locator<PermissionProvider>().setViewIdeal();

    final alarmSettings = AlarmSettings(
      id: _alarmId,
      dateTime: DateTime.now().add(const Duration(seconds: 2)),
      assetAudioPath: 'assets/mp3/alarm.mp3',
      loopAudio: true,
      vibrate: true,
      fadeDuration: 60,
      volume: 1,
      notificationTitle: 'This is the title',
      notificationBody: 'This is the body',
      enableNotificationOnKill: true,
    );
    await Alarm.set(alarmSettings: alarmSettings);

    return 'Alarm Triggered';
  } catch (e) {
    log(e.toString(), name: 'Error');
  }
  return 'Permission Denied';
}

String? _extractCommand(String? command) {
  if (command == null) {
    return null;
  }
  final formattedCommand = command.trim();
  final pass = locator<UserRepository>().user?.pin;

  log(pass.toString());

  if (pass == null) {
    return null;
  }

  final RegExp pattern = RegExp('^$_myHelper $pass\\s+');

  if (pattern.hasMatch(formattedCommand)) {
    final String withoutPrefix = formattedCommand.replaceFirst(pattern, '');

    final RegExp wordPattern = RegExp(r'^\w+');
    final match = wordPattern.firstMatch(withoutPrefix);
    if (match != null) {
      return match.group(0);
    }
  }

  return null;
}

String? _extractContactName(String? command) {
  if (command == null) {
    return null;
  }

  final RegExp pattern = RegExp('$_contactCommand\\s*(.+)');

  final match = pattern.firstMatch(command);

  if (match != null) {
    final String? extractedText = match.group(1);
    return extractedText?.trim();
  }

  return null;
}
