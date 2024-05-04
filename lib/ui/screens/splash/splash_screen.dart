import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';

// import '../../../core/provider/auth/auth_provider.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().start();

    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Image.asset(name)
            Expanded(
              child: Center(
                child: Text(
                  'My Helper',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            Text(
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
