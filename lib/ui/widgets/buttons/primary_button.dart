import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/theme_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String? icon;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final Color iconColor;
  final Color borderColor;
  final bool isLoading;

  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.icon,
    this.fontSize = 16,
    this.buttonColor = ThemeColors.primary,
    this.iconColor = Colors.black,
    this.textColor = ThemeColors.grey,
    this.borderColor = Colors.transparent,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(color: borderColor),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: buttonColor,
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: ThemeColors.primaryBg,
                  ),
                )
              : Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (icon != null)
                      SvgPicture.asset(
                        icon!,
                        fit: BoxFit.fitHeight,
                        height: 20,
                        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                      ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      );
}
