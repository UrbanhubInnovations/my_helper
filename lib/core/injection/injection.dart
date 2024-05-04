// ignore_for_file: prefer-static-class

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../model/settings/settings_model.dart';
import '../model/user/user_model.dart';
import '../router/app_router.dart';
import 'injection.config.dart';

final GetIt locator = GetIt.instance;

@InjectableInit(generateForDir: ['lib'])
Future<void> configureInjection() async => locator.init();

@module
abstract class RegisterModule {
  @lazySingleton
  AppRouter get instance => AppRouter();

  @lazySingleton
  @preResolve
  Future<Box<SettingsModel>> get settingsBox => Hive.openBox<SettingsModel>('settings');

  @lazySingleton
  @preResolve
  Future<Box<UserModel>> get userBox => Hive.openBox<UserModel>('users');
}
