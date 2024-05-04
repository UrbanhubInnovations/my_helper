import 'package:hive/hive.dart';

import '../model/settings/settings_model.dart';
import '../model/user/user_model.dart';


abstract class HiveAdapter {
  static void register() {
    Hive.registerAdapter(SettingsAdapter());
    Hive.registerAdapter(UserAdapter());
  }
}
