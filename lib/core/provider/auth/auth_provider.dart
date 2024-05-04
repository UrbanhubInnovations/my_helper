import 'package:injectable/injectable.dart';
import '../../../ui/utils/snack_bar/snack_bar_alert.dart';
import '../../model/user/user_model.dart';
import '../../repository/settings/settings_repository.dart';
import '../../repository/user/user_repository.dart';
import '../../router/app_router.dart';
import '../../router/app_router.gr.dart';
import '../base/base_provider.dart';

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

    if (!_settingsRepository.settings.hasLoggedIn) {
      await _appRouter.replaceAll([const LoginRoute()]);

      return;
    }

    _user = _userRepository.user;

    // await _appRouter.replaceAll([const LoginRoute()]);
    return;
  }
}
