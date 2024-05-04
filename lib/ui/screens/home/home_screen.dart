import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../../core/provider/permission/permission_provider.dart';
import '../../../core/router/app_router.gr.dart';
import '../../utils/constants/image_assets.dart';
import '../../utils/constants/theme_colors.dart';
import '../../widgets/buttons/primary_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.offWhite,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Helper'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: ThemeColors.black,
          ),
        ),
        drawer: const _Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Consumer<PermissionProvider>(
                builder: (context, provider, child) {
                  if (!provider.isAlarmRinging) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: PrimaryButton(
                      onTap: provider.stopAlarm,
                      text: 'Stop Alarm',
                    ),
                  );
                },
              ),
              _FeatureRow(
                icon: Icons.contacts_rounded,
                title: 'Access Contact',
                body: 'Click to see instruction',
                onTap: () => context.router.push(const ContactInstructionRoute()),
              ),
              _FeatureRow(
                icon: Icons.location_on_outlined,
                title: 'Access Location',
                body: 'Click to see instructions',
                onTap: () => context.router.push(const LocationInstructionRoute()),
              ),
              _FeatureRow(
                icon: CupertinoIcons.bell_fill,
                title: 'Change Sound Profile',
                body: 'Click to see instructions',
                onTap: () => context.router.push(const SoundProfileInstructionRoute()),
              ),
              _FeatureRow(
                icon: Icons.alarm,
                title: 'Alarm Mobile',
                body: 'Click to see instructions',
                onTap: () => context.router.push(const AlarmInstructionRoute()),
              ),
            ],
          ),
        ),
      );
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) => Drawer(
        shape: const ContinuousRectangleBorder(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Consumer<AuthProvider>(
              builder: (context, provider, child) => DecoratedBox(
                decoration: const BoxDecoration(
                  color: ThemeColors.primary,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        SizedBox(
                          height: 65,
                          width: 65,
                          child: Image.asset(ImageAssets.logo),
                        ),
                        const Gap(20),
                        Text(
                          provider.user?.name ?? '',
                          style: const TextStyle(
                            color: ThemeColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          provider.user?.email ?? '',
                          style: const TextStyle(
                            color: ThemeColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(
                CupertinoIcons.house_fill,
                size: 20,
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_right,
                size: 15,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('History'),
              leading: const Icon(
                Icons.history,
                size: 20,
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_right,
                size: 15,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(
                Icons.settings,
                size: 20,
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_right,
                size: 15,
              ),
              onTap: () => context.router.push(const SettingsRoute()),
            ),
            ListTile(
              title: const Text('Grant Permission'),
              leading: const Icon(
                CupertinoIcons.checkmark_shield_fill,
                size: 20,
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_right,
                size: 15,
              ),
              onTap: () => context.router.push(const PermissionRoute()),
            ),
            ListTile(
              title: const Text(
                'Share',
              ),
              leading: const Icon(
                Icons.share,
                size: 20,
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_right,
                size: 15,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      );
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;

  final String title;
  final String body;

  final VoidCallback onTap;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.body,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 80,
                  child: Icon(
                    icon,
                    color: ThemeColors.primary,
                    size: 40,
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Gap(5),
                      Text(
                        body,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
