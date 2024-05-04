import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_field/primary_text_form_field.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const PrimaryTextField(hintText: 'Email'),
                const Gap(15),
                const PrimaryTextField(hintText: 'Password'),
                const Gap(15),
                PrimaryButton(onTap: () => {}, text: 'Login'),
              ],
            ),
          ),
        ),
      );
}
