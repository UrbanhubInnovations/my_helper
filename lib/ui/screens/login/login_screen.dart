import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../../core/router/app_router.gr.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_field/primary_text_form_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailCtr;
  late final TextEditingController _passwordCtr;

  @override
  void initState() {
    super.initState();
    _emailCtr = TextEditingController();
    _passwordCtr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                PrimaryTextField(
                  hintText: 'Email',
                  controller: _emailCtr,
                ),
                const Gap(15),
                PrimaryTextField(
                  hintText: 'Password',
                  controller: _passwordCtr,
                ),
                const Gap(15),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) => PrimaryButton(
                    isLoading: provider.isBusy,
                    onTap: () => provider.login(
                      email: _emailCtr.text.trim(),
                      password: _passwordCtr.text.trim(),
                    ),
                    text: 'Login',
                  ),
                ),
                const Gap(30),
                PrimaryButton(
                  onTap: () => context.router.push(const RegisterRoute()),
                  text: 'Create Account',
                  buttonColor: Colors.transparent,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _passwordCtr.dispose();
    _emailCtr.dispose();
    super.dispose();
  }
}
