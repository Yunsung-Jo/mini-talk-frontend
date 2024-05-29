import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minitalk/res/colors.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle._init();
  AppTextStyle._init();

  final TextStyle notoSansBold30 = GoogleFonts.notoSansKr(
    color: AppColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  final TextStyle notoSansBold25 = GoogleFonts.notoSansKr(
    color: AppColors.text,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  final TextStyle notoSansBold20 = GoogleFonts.notoSansKr(
    color: AppColors.text,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  final TextStyle notoSans15 = GoogleFonts.notoSansKr(
    color: AppColors.text,
    fontSize: 15,
  );

  final TextStyle notoSans12 = GoogleFonts.notoSansKr(
    color: AppColors.hint,
    fontSize: 12,
  );

  final TextStyle notoSansBold12 = GoogleFonts.notoSansKr(
    color: AppColors.hint,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
}
