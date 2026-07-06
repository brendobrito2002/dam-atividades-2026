import 'package:flutter/material.dart';

import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffix,
    required this.controller,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.onChanged,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffix;
  final BorderRadius borderRadius;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: AppColors.black800,
        borderRadius: borderRadius,
      ),
      child: TextFormField(
        cursorColor: AppColors.primary,
        style: AppTextStyle.bodyText1,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffix,
          hintText: hintText,
          hintStyle: AppTextStyle.bodyText1.copyWith(color: AppColors.gray500),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
