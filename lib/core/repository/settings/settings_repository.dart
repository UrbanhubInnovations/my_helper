import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../model/settings/settings_model.dart';

@lazySingleton
class SettingsRepository {
  final Box<SettingsModel> _settingsBox;

  SettingsModel get settings => _settingsBox.get('settings')!;

  const SettingsRepository(this._settingsBox);

  Future<void> initialize() async {
    if (_settingsBox.isEmpty) {
      await _saveSettings(const SettingsModel());
    }
  }

  Future<void> saveHasOnboarded() async => _saveSettings(settings.copyWith(hasOnboarded: true));

  Future<void> saveLogin({bool isLoggedIn = false}) async => _saveSettings(settings.copyWith(hasLoggedIn: isLoggedIn));

  Future<void> reset() async => _saveSettings(const SettingsModel());

  Future<void> _saveSettings(SettingsModel settings) async => _settingsBox.put('settings', settings);
}
