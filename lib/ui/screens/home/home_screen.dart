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
                onTap: () => {},
              ),
              _FeatureRow(
                  icon: Icons.location_on_outlined,
                  title: 'Access Location',
                  body: 'Click to see instructions',
                  onTap: () => {}),
              _FeatureRow(
                  icon: CupertinoIcons.bell_fill,
                  title: 'Change Sound Profile',
                  body: 'Click to see instructions',
                  onTap: () => {}),
              _FeatureRow(
                  icon: Icons.alarm,
                  title: 'Alarm Mobile',
                  body: 'Click to see instructions',
                  onTap: () => {})
            ],
          ),
        ),
      );
}

class _Drawer extends StatelessWidget {
  const _Drawer();

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              trailing: const Icon(Icons.home),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('History'),
              trailing: const Icon(Icons.history),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Settings'),
              trailing: const Icon(Icons.settings),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Grant Permission'),
              trailing: const Icon(Icons.done_rounded),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Share'),
              trailing: const Icon(Icons.share),
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
  Widget build(BuildContext context) => Padding(
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
                width: 100,
                child: Icon(
                  icon,
                  color: ThemeColors.primary,
                  size: 40,
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
      );
}
