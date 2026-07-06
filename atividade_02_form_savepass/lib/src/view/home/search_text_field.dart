import 'package:flutter/material.dart';
import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/components/custom_text_field.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomTextField(
              hintText: hintText,
              controller: controller,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              onChanged: onChanged,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColors.black900,
                size: 24,
              ),
            ),
          )
        ],
      ),
    );
  }
}
