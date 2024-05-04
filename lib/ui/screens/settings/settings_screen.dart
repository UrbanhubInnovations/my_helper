import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/constants/theme_colors.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Settings'),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            color: ThemeColors.black,
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GeneralSettings(),
              Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
              ),
              _PrivacySettings(),
            ],
          ),
        ),
      );
}

class _GeneralSettings extends StatelessWidget {
  const _GeneralSettings();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
            ),
            const Gap(15),
            _GeneralSettingsRow(
              title: 'Change name',
              icon: CupertinoIcons.person_alt_circle_fill,
              onTap: () {},
            ),
            _GeneralSettingsRow(
              title: 'Change login password',
              icon: CupertinoIcons.person_alt_circle_fill,
              onTap: () {},
            ),
            _GeneralSettingsRow(
              title: 'Change lock pin',
              icon: CupertinoIcons.person_alt_circle_fill,
              onTap: () {},
            ),
          ],
        ),
      );
}

class _GeneralSettingsRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _GeneralSettingsRow({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            children: [
              Icon(
                icon,
                color: ThemeColors.grey,
                size: 25,
              ),
              const Gap(15),
              Expanded(
                child: Text(
                  title,
                ),
              ),
            ],
          ),
        ),
      );
}

class _PrivacySettings extends StatelessWidget {
  const _PrivacySettings();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Settings',
            ),
            const Gap(15),
            _PrivacySettingsRow(
              title: 'Change name',
              description: 'hg',
              icon: CupertinoIcons.person_alt_circle_fill,
              onTap: () {},
            ),
          ],
        ),
      );
}

class _PrivacySettingsRow extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _PrivacySettingsRow({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            children: [
              Icon(
                icon,
                color: ThemeColors.grey,
                size: 25,
              ),
              const Gap(15),
              Expanded(
                child: Text(
                  title,
                ),
              ),
            ],
          ),
        ),
      );
}
