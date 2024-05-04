import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../../core/router/app_router.gr.dart';
import '../../utils/constants/image_assets.dart';
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.logo,height: 120, width: 120,
                  ),
                  const Gap(40),
                  PrimaryTextField(
                    hintText: 'Email',
                    controller: _emailCtr,
                  ),
                  const Gap(15),
                  PrimaryTextField(
                    hintText: 'Password',
                    controller: _passwordCtr,
                  ),
                  const Gap(40),
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
                  const Gap(20),
                  PrimaryButton(
                    onTap: () => context.router.push(const RegisterRoute()),
                    text: 'No account yet? Create Account',
                    buttonColor: Colors.transparent,
                    fontSize: 14,
                  ),
                ],
              ),
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
