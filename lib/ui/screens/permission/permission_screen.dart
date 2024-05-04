import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/permission/permission_provider.dart';
import '../../utils/constants/theme_colors.dart';
import '../../widgets/buttons/primary_button.dart';

@RoutePage()
class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<PermissionProvider>(
              builder: (context, provider, child) => Column(
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
                ],
              ),
            ),
          ),
        ),
      );
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
              child: PrimaryButton(
                onTap: () {
                  if (!isDisabled) {
                    onTapSetup();
                  }
                },
                text: 'Setup',
                textColor: ThemeColors.white,
                buttonColor: isDisabled ? ThemeColors.grey : ThemeColors.primary,
              ),
            ),
          ],
        ),
      );
}
