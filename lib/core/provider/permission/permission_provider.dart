import 'dart:async';
import 'dart:developer';

import 'package:another_telephony/telephony.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/base_provider.dart';

@lazySingleton
class PermissionProvider extends BaseProvider {
  final telephony = Telephony.instance;
  bool _hasSMSPermission = false;
  bool _hasContactPermission = false;

  bool get hasSMSPermission => _hasSMSPermission;

  bool get hasContactPermission => _hasContactPermission;


  bool get isAllAllowed => hasSMSPermission && hasContactPermission;

  PermissionProvider();

  Future<void> initializePermissions() async {
    _hasSMSPermission = await Permission.sms.isGranted;
    _hasContactPermission = await Permission.contacts.isGranted;
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

  Future<void> _setupSMS() async {
    log('jahsvj');
    if (!(_hasSMSPermission && _hasContactPermission)) {
      return;
    }

    await telephony.requestPhoneAndSmsPermissions;

    log('jahsvj---');
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) async {
        log(message.address.toString());
        final contact = await _getContact(message.body);

        await telephony.sendSms(
          to: message.address ?? '',
          message: "Message from foreground, Contact for '${message.body}' - $contact",
        );
      },
      onBackgroundMessage: backgroundMessageHandler,
    );
  }
}

@pragma('vm:entry-point')
Future<void> backgroundMessageHandler(SmsMessage message) async {
  log(message.address.toString());
  log(message.serviceCenterAddress.toString());
  log(message.subscriptionId.toString());
  log(message.subject.toString());
  final contact = await _getContact(message.body);

  unawaited(
    Telephony.backgroundInstance.sendSms(
      to: '9995265990',
      message: "Message from Background, Contact for '${message.body}' - $contact",
    ),
  );
}

Future<String> _getContact(String? name) async {
  final List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);

  Contact? contact;
  for (final element in contacts) {
    if (element.displayName == (name ?? '---Not Found---')) {
      contact = element;
    }
  }

  return contact?.phones.map((e) => e.number.toString()).join(
            ', ',
          ) ??
      'Not Found';
}
