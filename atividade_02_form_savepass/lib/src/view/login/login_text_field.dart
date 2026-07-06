import 'package:flutter/material.dart';

import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/text_styles.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.icon,
      required this.controller});

  final String hintText;
  final bool obscureText;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        cursorColor: AppColors.primary,
        style: AppTextStyle.bodyText1,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: AppColors.gray200,
            size: 24,
          ),
          hintText: hintText,
          hintStyle: AppTextStyle.bodyText1.copyWith(color: AppColors.gray500),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors.primary, width: 2.0),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
