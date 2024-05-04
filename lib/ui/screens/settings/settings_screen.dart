import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../../core/provider/permission/permission_provider.dart';
import '../../../core/router/app_router.gr.dart';
import '../../utils/constants/theme_colors.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_field/primary_text_form_field.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
          titleTextStyle: const TextStyle(
            fontSize: 17,
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
              onTap: () => _showDialog(
                context,
                (context) => const _ChangeNameModal(),
              ),
            ),
            _GeneralSettingsRow(
              title: 'Change login password',
              icon: CupertinoIcons.lock_shield_fill,
              onTap: () => _showDialog(
                context,
                (context) => const _ChangePasswordModal(),
              ),
            ),
            _GeneralSettingsRow(
              title: 'Change lock pin',
              icon: CupertinoIcons.lock_fill,
              onTap: () => context.router.push(const ChangePinRoute()),
            ),
          ],
        ),
      );

  void _showDialog(BuildContext context, Widget Function(BuildContext context) widget) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: widget,
    );
  }
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
                  style: const TextStyle(
                    fontSize: 14,
                  ),
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
        child: Consumer<PermissionProvider>(
          builder: (context, provider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Settings',
              ),
              const Gap(15),
              _PrivacySettingsRow(
                title: 'Contacts',
                description: 'Get contacts...',
                icon: CupertinoIcons.person_2_square_stack_fill,
                isEnabled: provider.enableContact,
                onChange: (value) => provider.savePreference(enableContact: value),
              ),
              _PrivacySettingsRow(
                title: 'Location',
                description: 'Get location...',
                icon: CupertinoIcons.location_solid,
                isEnabled: provider.enableLocation,
                onChange: (value) => provider.savePreference(enableLocation: value),
              ),
              _PrivacySettingsRow(
                title: 'Ring Profile',
                description: 'Change ring profile...',
                icon: CupertinoIcons.bell_fill,
                isEnabled: provider.enableSoundProfile,
                onChange: (value) => provider.savePreference(enableSoundProfile: value),
              ),
              _PrivacySettingsRow(
                title: 'Alarm',
                description: 'Alarm your...',
                icon: CupertinoIcons.alarm_fill,
                isEnabled: provider.enableAlarm,
                onChange: (value) => provider.savePreference(enableAlarm: value),
              ),
            ],
          ),
        ),
      );
}

class _PrivacySettingsRow extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final ValueSetter<bool> onChange;
  final bool isEnabled;

  const _PrivacySettingsRow({
    required this.title,
    required this.description,
    required this.icon,
    required this.onChange,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) => Padding(
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
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: ThemeColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isEnabled,
              onChanged: onChange,
              activeTrackColor: ThemeColors.white,
            ),
          ],
        ),
      );
}

class _ChangeNameModal extends StatefulWidget {
  const _ChangeNameModal();

  @override
  State<_ChangeNameModal> createState() => _ChangeNameModalState();
}

class _ChangeNameModalState extends State<_ChangeNameModal> {
  late final TextEditingController _nameCtr;

  @override
  void initState() {
    super.initState();
    _nameCtr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextField(
                hintText: 'New name',
                controller: _nameCtr,
              ),
              const Gap(20),
              Consumer<AuthProvider>(
                builder: (context, provider, child) => PrimaryButton(
                  isLoading: provider.isBusy,
                  onTap: () {
                    provider.updateName(
                      newName: _nameCtr.text.trim(),
                    );
                    context.maybePop();
                  },
                  text: 'Update Name',
                  textColor: ThemeColors.white,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _nameCtr.dispose();
    super.dispose();
  }
}

class _ChangePasswordModal extends StatefulWidget {
  const _ChangePasswordModal();

  @override
  State<_ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<_ChangePasswordModal> {
  late final TextEditingController _passwordCtr;
  late final TextEditingController _confirmPasswordCtr;

  @override
  void initState() {
    super.initState();
    _passwordCtr = TextEditingController();
    _confirmPasswordCtr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextField(
                hintText: 'New Password',
                controller: _passwordCtr,
              ),
              const Gap(20),
              PrimaryTextField(
                hintText: 'Confirm New Password',
                controller: _confirmPasswordCtr,
              ),
              const Gap(20),
              Consumer<AuthProvider>(
                builder: (context, provider, child) => PrimaryButton(
                  isLoading: provider.isBusy,
                  onTap: () {
                    provider.updatePassword(
                      newPassword: _passwordCtr.text.trim(),
                      confirmPassword: _confirmPasswordCtr.text.trim(),
                    );
                    context.maybePop();
                  },
                  text: 'Update Password',
                  textColor: ThemeColors.white,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _passwordCtr.dispose();
    _confirmPasswordCtr.dispose();
    super.dispose();
  }
}
