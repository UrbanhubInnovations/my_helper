import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                PrimaryTextField(
                  hintText: 'Name',
                  controller: _nameCtr,
                ),
                const Gap(15),
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
                PrimaryTextField(
                  hintText: 'Confirm Password',
                  controller: _confirmPasswordCtr,
                ),
                const Gap(15),
                PrimaryTextField(
                  hintText: '4 Digit Pincode',
                  controller: _pincodeCtr,
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
                  ),
                ),
                const Gap(30),
                PrimaryButton(
                  onTap: () => context.router.maybePop(),
                  text: 'Already have account?\nSign In',
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
