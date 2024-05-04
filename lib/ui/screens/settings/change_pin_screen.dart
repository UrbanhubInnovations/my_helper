import 'package:auto_route/auto_route.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth/auth_provider.dart';
import '../../utils/constants/theme_colors.dart';

@RoutePage()
class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  late final TextEditingController _controller;

  String _pin = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Change Lock Pin'),
          titleTextStyle: const TextStyle(
            fontSize: 17,
            color: ThemeColors.black,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Gap(20),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 35,
                ),
                child: Text(
                  'Enter New Pin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    _PinCodeField(
                      key: Key('pinField$i'),
                      pin: _pin,
                      pinCodeFieldIndex: i,
                    ),
                ],
              ),
              const Gap(20),
              CustomKeyBoard(
                specialKey: const SizedBox(),
                specialKeyOnTap: () {},
                onCompleted: (pin) {
                  context.read<AuthProvider>().updatePin(pincode: _pin);
                  context.maybePop();
                },
                pinTheme: PinTheme(
                  textColor: Colors.red,
                  keysColor: ThemeColors.black,
                ),
                onChanged: (pin) => setState(() => _pin = pin),
                maxLength: 4,
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _PinCodeField extends StatelessWidget {
  const _PinCodeField({
    required this.pin,
    required this.pinCodeFieldIndex,
    super.key,
  });

  final String pin;

  final int pinCodeFieldIndex;

  Color get getFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return Colors.black;
    } else if (pin.length == pinCodeFieldIndex) {
      return Colors.black45;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        height: 40,
        width: 40,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: getFillColorFromIndex,
          shape: BoxShape.circle,
          border: Border.all(
            color: getFillColorFromIndex,
            width: 2,
          ),
        ),
        duration: const Duration(microseconds: 40000),
        child: pin.length > pinCodeFieldIndex
            ? const Icon(
                Icons.circle,
                color: Colors.white,
                size: 12,
              )
            : const SizedBox(),
      );
}
