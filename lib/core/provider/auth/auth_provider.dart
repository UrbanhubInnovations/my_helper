import 'dart:developer';

import 'package:injectable/injectable.dart';

import '../../../ui/utils/snack_bar/snack_bar_alert.dart';
import '../../injection/injection.dart';
import '../../model/user/user_model.dart';
import '../../repository/settings/settings_repository.dart';
import '../../repository/user/user_repository.dart';
import '../../router/app_router.dart';
import '../../router/app_router.gr.dart';
import '../base/base_provider.dart';
import '../permission/permission_provider.dart';

@lazySingleton
class AuthProvider extends BaseProvider {
  final AppRouter _appRouter;

  final SnackBarAlert _snackBarAlert;
  final SettingsRepository _settingsRepository;
  final UserRepository _userRepository;

  UserModel? _user;

  UserModel? get user => _user;

  AuthProvider(
    this._appRouter,
    this._settingsRepository,
    this._userRepository,
    this._snackBarAlert,
  );

  Future<void> start() async {
    await Future.delayed(const Duration(seconds: 2));

    await locator<PermissionProvider>().initializePermissions();

    if (!locator<PermissionProvider>().isAllAllowed) {
      await _appRouter.replaceAll([const PermissionRoute()]);

      return;
    }

    if (!_settingsRepository.settings.hasLoggedIn) {
      await _appRouter.replaceAll([const LoginRoute()]);

      return;
    }

    _user = _userRepository.user;
    notifyListeners();

    await _appRouter.replaceAll([const HomeRoute()]);
    return;
  }

  Future<void> login({required String email, required String password}) async {
    try {
      if (email.isEmpty) {
        _snackBarAlert.showToast(message: 'Please enter email.');
        return;
      }

      if (password.isEmpty) {
        _snackBarAlert.showToast(message: 'Please enter password.');
        return;
      }

      final user = _userRepository.user;

      if (user == null || user.email != email || user.password != password) {
        _snackBarAlert.showToast(message: 'Invalid credentials.');
        return;
      }

      await _settingsRepository.saveLogin(isLoggedIn: true);
      _user = user;
      await _appRouter.replaceAll([const HomeRoute()]);
    } catch (e) {
      _snackBarAlert.showToast(message: 'Something went wrong.');
      log(e.toString(), name: 'Error');
    } finally {
      setViewIdeal();
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String pincode,
  }) async {
    try {
      if (name.isEmpty) {
        _snackBarAlert.showToast(message: 'Please enter name.');
        return;
      }
      if (email.isEmpty) {
        _snackBarAlert.showToast(message: 'Please enter email.');
        return;
      }

      if (password.isEmpty) {
        _snackBarAlert.showToast(message: 'Please enter password.');
        return;
      }

      if (password != confirmPassword) {
        _snackBarAlert.showToast(message: 'Password doesn\'t match.');
        return;
      }

      if (pincode.length != 4) {
        _snackBarAlert.showToast(message: 'Please enter a valid pincode.');
        return;
      }

      setViewBusy();

      final user = UserModel(
        name: name,
        email: email,
        password: password,
        pin: int.parse(pincode),
        createdAt: DateTime.now().toString(),
      );

      await _userRepository.saveUser(user);
      await _settingsRepository.saveLogin(isLoggedIn: true);

      _user = user;
      await _appRouter.replaceAll([const HomeRoute()]);
    } catch (e) {
      _snackBarAlert.showToast(message: 'Something went wrong.');
      log(e.toString(), name: 'Error');
    } finally {
      setViewIdeal();
    }
  }
}
