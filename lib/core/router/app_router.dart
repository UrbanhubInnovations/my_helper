import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      path: '/',
      page: SplashRoute.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/permission', page: PermissionRoute.page),
    AutoRoute(path: '/register', page: RegisterRoute.page),
    AutoRoute(path: '/home', page: HomeRoute.page),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
    AutoRoute(path: '/change-pin', page: ChangePinRoute.page),
    AutoRoute(path: '/contact-instruction', page: ContactInstructionRoute.page),
    AutoRoute(path: '/location-instruction', page: LocationInstructionRoute.page),
    AutoRoute(path: '/alarm-instruction', page: AlarmInstructionRoute.page),
    AutoRoute(path: '/sound-profile-instruction', page: SoundProfileInstructionRoute.page),
  ];
}
