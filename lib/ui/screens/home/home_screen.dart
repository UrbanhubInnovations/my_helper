import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/constants/theme_colors.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.offWhite,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Helper'),
        ),
        drawer: const _Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _FeatureRow(
                icon: Icons.contacts_rounded,
                title: 'Access Contact',
                body: 'Click to see instruction',
                onTap: () => {},
              )
            ],
          ),
        ),
      );
}

class _Drawer extends StatelessWidget {
  const _Drawer({super.key});

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
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
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
              )
            ],
          ),
        ),
      );
}
