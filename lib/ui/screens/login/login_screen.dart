import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../../core/router/app_router.gr.dart';
import '../../utils/constants/image_assets.dart';
import '../../utils/constants/theme_colors.dart';
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Gap(40),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  child: Image.asset(ImageAssets.logo),
                ),
                const Gap(40),
                PrimaryTextField(
                  hintText: 'Email',
                  controller: _emailCtr,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const Gap(15),
                PrimaryTextField(
                  hintText: 'Password',
                  controller: _passwordCtr,
                ),
                const Gap(20),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) => PrimaryButton(
                    isLoading: provider.isBusy,
                    onTap: () => provider.login(
                      email: _emailCtr.text.trim(),
                      password: _passwordCtr.text.trim(),
                    ),
                    text: 'Login',
                    textColor: ThemeColors.white,
                  ),
                ),
                const Gap(40),
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
      );

  @override
  void dispose() {
    _passwordCtr.dispose();
    _emailCtr.dispose();
    super.dispose();
  }
}
