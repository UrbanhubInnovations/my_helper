import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../utils/constants/image_assets.dart';
import '../../utils/constants/theme_colors.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/text_field/primary_text_form_field.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameCtr;
  late final TextEditingController _emailCtr;
  late final TextEditingController _passwordCtr;
  late final TextEditingController _confirmPasswordCtr;
  late final TextEditingController _pincodeCtr;

  @override
  void initState() {
    super.initState();
    _nameCtr = TextEditingController();
    _emailCtr = TextEditingController();
    _passwordCtr = TextEditingController();
    _confirmPasswordCtr = TextEditingController();
    _pincodeCtr = TextEditingController();
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
                  hintText: 'Name',
                  controller: _nameCtr,
                  textInputAction: TextInputAction.next,
                ),
                const Gap(15),
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
                  textInputAction: TextInputAction.next,
                ),
                const Gap(15),
                PrimaryTextField(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordCtr,
                  textInputAction: TextInputAction.next,
                ),
                const Gap(15),
                PrimaryTextField(
                  hintText: '4 Digit Pincode',
                  controller: _pincodeCtr,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
                const Gap(15),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) => PrimaryButton(
                    isLoading: provider.isBusy,
                    onTap: () => provider.register(
                      name: _nameCtr.text.trim(),
                      email: _emailCtr.text.trim(),
                      password: _passwordCtr.text.trim(),
                      confirmPassword: _confirmPasswordCtr.text.trim(),
                      pincode: _pincodeCtr.text.trim(),
                    ),
                    text: 'Signup',
                    textColor: ThemeColors.white,
                  ),
                ),
                const Gap(30),
                PrimaryButton(
                  onTap: () => context.router.maybePop(),
                  text: 'Already have account? Sign In',
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
    _nameCtr.dispose();
    _emailCtr.dispose();
    _passwordCtr.dispose();
    _confirmPasswordCtr.dispose();
    _pincodeCtr.dispose();
    super.dispose();
  }
}
