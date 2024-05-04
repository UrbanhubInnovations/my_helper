import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../utils/constants/image_assets.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().start();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(ImageAssets.logo),
            const Expanded(
              child: Center(
                child: Text(
                  'My Helper',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            const Text(
              'Powered By Students of\nJaypee University of Guna MP',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
