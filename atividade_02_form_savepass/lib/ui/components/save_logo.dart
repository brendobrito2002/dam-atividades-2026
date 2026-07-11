import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_pass/ui/colors.dart';
import 'package:save_pass/ui/font_weights.dart';

class SavePassLogo extends StatelessWidget {
  const SavePassLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: 'Save',
                style: GoogleFonts.fuzzyBubbles(
                  color: AppColors.white,
                  fontSize: 48,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'PASS',
                style: GoogleFonts.roboto(
                  color: AppColors.primary,
                  fontSize: 48,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.lock,
          color: AppColors.primary,
          size: 48,
        ),
      ],
    );
  }
}
