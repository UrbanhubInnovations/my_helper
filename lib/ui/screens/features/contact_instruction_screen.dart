import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/constants/image_assets.dart';
import '../../utils/constants/theme_colors.dart';

@RoutePage()
class ContactInstructionScreen extends StatelessWidget {
  const ContactInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Access Contact'),
          titleTextStyle: const TextStyle(
            fontSize: 17,
            color: ThemeColors.black,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'You need to send message in the format as shown below:',
                  ),
                  const Gap(10),
                  const Text(
                    'MyHelper <YourPincode> getContact <ContactName>',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'For example:',
                  ),
                  const Gap(5),
                  Image.asset(
                    ImageAssets.contactExample,
                  ),
                  const Gap(5),
                  const Text(
                    'Note: The contact name is case insensitive.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
