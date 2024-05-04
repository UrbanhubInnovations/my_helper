import 'package:flutter/material.dart';

import '../../utils/constants/theme_colors.dart';

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autoFocus;
  final TextEditingController? controller;
  final void Function(String query)? onChanged;
  final String? Function(String? value)? validate;
  final Icon? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? suffixText;

  const PrimaryTextField({
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.autoFocus = false,
    super.key,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.validate,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        validator: validate,
        style: const TextStyle(
          fontSize: 14,
          color: ThemeColors.black,
        ),
        textInputAction: textInputAction,
        autofocus: autoFocus,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          suffixText: suffixText,
          suffixStyle: const TextStyle(
            color: ThemeColors.greyText,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          prefixIcon: prefixIcon,
          prefixIconColor: ThemeColors.grey,
          contentPadding: const EdgeInsets.all(16),
          isDense: false,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ThemeColors.greyText,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: ThemeColors.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: ThemeColors.grey),
          ),
        ),
      );
}
//
// class SecondaryTextFormField extends StatelessWidget {
//   final String hintText;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final bool autoFocus;
//   final String? suffixText;
//   final Icon? icon;
//   final TextEditingController? controller;
//   final VoidCallback? onTap;
//   final String? Function(String? value)? validate;
//
//   const SecondaryTextFormField({
//     required this.hintText,
//     this.onTap,
//     this.keyboardType,
//     this.textInputAction,
//     this.autoFocus = false,
//     super.key,
//     this.icon,
//     this.suffixText,
//     this.controller,
//     this.validate,
//   });
//
//   @override
//   Widget build(BuildContext context) => TextFormField(
//         validator: validate,
//         onTap: onTap,
//         controller: controller,
//         style: const TextStyle(
//           fontSize: ThemeTextStyle.body2,
//           color: ThemeColors.white,
//         ),
//         textInputAction: textInputAction,
//         autofocus: autoFocus,
//         keyboardType: keyboardType,
//         textCapitalization: TextCapitalization.sentences,
//         decoration: InputDecoration(
//           suffixText: suffixText,
//           suffixStyle: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w400,
//             fontSize: ThemeTextStyle.body3,
//           ),
//           prefixIcon: icon,
//           prefixIconColor: ThemeColors.grey,
//           contentPadding: const EdgeInsets.all(16),
//           isDense: false,
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             fontSize: ThemeTextStyle.body1,
//             color: ThemeColors.grey,
//           ),
//           errorBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//             borderSide: BorderSide(color: ThemeColors.red),
//           ),
//           focusedErrorBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//             borderSide: BorderSide(color: ThemeColors.red),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//             borderSide: BorderSide(color: ThemeColors.primaryBorder),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//             borderSide: BorderSide(color: ThemeColors.primaryBorder),
//           ),
//         ),
//       );
// }
