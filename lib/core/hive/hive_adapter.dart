import 'package:hive/hive.dart';

import '../model/settings/settings_model.dart';
import '../model/user/user_model.dart';

abstract class HiveAdapter {
  static void register() {
    if (!Hive.isAdapterRegistered(SettingsAdapter().typeId)) {
      Hive.registerAdapter(SettingsAdapter());
    }
    if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
      Hive.registerAdapter(UserAdapter());
    }
  }
}
