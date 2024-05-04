import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/injection/injection.dart';
import '../../../core/provider/auth/auth_provider.dart';
import '../../../core/provider/permission/permission_provider.dart';
import '../../utils/constants/theme_colors.dart';
import '../../widgets/buttons/primary_button.dart';

@RoutePage()
class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      locator<PermissionProvider>().initializePermissions();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Setup Permissions'),
          titleTextStyle: const TextStyle(
            fontSize: 16,
            color: ThemeColors.black,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Consumer<PermissionProvider>(
                    builder: (context, provider, child) => ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _PermissionRow(
                          number: '1.',
                          title: 'Grant SMS Permission',
                          body: 'Click to allow permission.',
                          onTapSetup: () => context.read<PermissionProvider>().setupSMSPermission(),
                          isDisabled: provider.hasSMSPermission,
                        ),
                        _PermissionRow(
                          number: '2.',
                          title: 'Grant Contact Permission',
                          body: 'Click to allow permission.',
                          onTapSetup: () => context.read<PermissionProvider>().setupContactPermission(),
                          isDisabled: provider.hasContactPermission,
                        ),
                        _PermissionRow(
                          number: '3.',
                          title: 'Grant Sound Profile Permission',
                          body: 'Click to allow permission.',
                          onTapSetup: () => context.read<PermissionProvider>().setupSoundProfilePermission(),
                          isDisabled: provider.hasSoundProfilePermission,
                        ),
                        _PermissionRow(
                          number: '4.',
                          title: 'Grant Location Permission',
                          body: 'Click to allow permission.',
                          onTapSetup: () => context.read<PermissionProvider>().setupLocationPermission(),
                          isDisabled: provider.hasLocationPermission,
                        ),
                        _PermissionRow(
                          number: '5.',
                          title: 'Grant Location Service',
                          body: 'Click to allow service.',
                          onTapSetup: () => context.read<PermissionProvider>().setupLocationServicePermission(),
                          isDisabled: provider.hasLocationServicePermission,
                        ),
                        _PermissionRow(
                          number: '6.',
                          title: 'Grant Alarm Permission',
                          body: 'Click to allow permission.',
                          onTapSetup: () => context.read<PermissionProvider>().setupAlarmPermission(),
                          isDisabled: provider.hasAlarmPermission,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Consumer<PermissionProvider>(
                    builder: (context, provider, child) {
                      if (provider.isAllAllowed) {
                        return PrimaryButton(
                          onTap: () => context.read<AuthProvider>().start(withoutDelay: true),
                          text: 'Continue',
                          textColor: ThemeColors.white,
                        );
                      }

                      return const SizedBox();
                    },
                  ))
            ],
          ),
        ),
      );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _PermissionRow extends StatelessWidget {
  final String number;
  final String title;
  final String body;

  final VoidCallback onTapSetup;

  final bool isDisabled;

  const _PermissionRow({
    required this.title,
    required this.number,
    required this.body,
    required this.onTapSetup,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 70,
              height: 40,
              child: isDisabled
                  ? const Icon(
                      Icons.done_rounded,
                      size: 20,
                      color: Colors.green,
                    )
                  : PrimaryButton(
                      onTap: onTapSetup,
                      text: 'Setup',
                      fontSize: 14,
                      textColor: ThemeColors.white,
                      buttonColor: ThemeColors.primary,
                    ),
            ),
          ],
        ),
      );
}
