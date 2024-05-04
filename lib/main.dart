import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'core/hive/hive_adapter.dart';
import 'core/injection/injection.dart';
import 'core/provider/base/multi_providers.dart';
import 'core/repository/settings/settings_repository.dart';
import 'core/router/app_router.dart';
import 'ui/utils/constants/theme_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(
    MultiProvider(
      providers: MultiProviders.providers,
      child: const MyApp(),
    ),
  );
}

Future<void> _initialize() async {
  await Hive.initFlutter();
  HiveAdapter.register();
  await configureInjection();
  await _initializeConfig();
}

Future<void> _initializeConfig() async {
  await locator<SettingsRepository>().initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = locator<AppRouter>();

    return OverlaySupport.global(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'My Helper',
          routerConfig: appRouter.config(),
          theme: ThemeData(
            dialogTheme: const DialogTheme(
              surfaceTintColor: Colors.transparent,
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              surfaceTintColor: Colors.transparent,
            ),
            scaffoldBackgroundColor: ThemeColors.offWhite,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: ThemeColors.primaryMaterial),
            useMaterial3: true,
            fontFamily: 'Poppins',
          ),
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);

            return MediaQuery(
              data: data.copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
