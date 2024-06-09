import 'package:flutter/material.dart';
import 'package:minitalk/res/colors.dart';

class AppDecorationStyle {
  static AppDecorationStyle instance = AppDecorationStyle._init();
  AppDecorationStyle._init();

  final InputDecoration lightGray = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.lightGray),
    ),
    enabledBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.lightGray),
    ),
    counter: const SizedBox.shrink(),
  );
}
