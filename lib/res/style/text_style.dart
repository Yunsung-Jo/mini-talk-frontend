import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minitalk/res/colors.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle._init();
  AppTextStyle._init();

  final TextStyle titleBold_30 = GoogleFonts.notoSansKr(
    color: AppColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  final TextStyle titleBold_25 = GoogleFonts.notoSansKr(
    color: AppColors.text,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  final TextStyle titleBold_20 = GoogleFonts.notoSansKr(
    color: AppColors.text,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  final TextStyle content_16 = GoogleFonts.notoSansKr(
    color: AppColors.text,
    fontSize: 16,
  );

  final TextStyle content_12 = GoogleFonts.notoSansKr(
    color: AppColors.hint,
    fontSize: 12,
  );

  final TextStyle contentBold_12 = GoogleFonts.notoSansKr(
    color: AppColors.hint,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
}
