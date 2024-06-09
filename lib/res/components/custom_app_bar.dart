import 'package:flutter/material.dart';
import 'package:minitalk/res/style/text_style.dart';

class CustomAppBar extends AppBar {
  final BuildContext context;
  final String label;
  final List<Widget>? actionList;

  CustomAppBar({
    super.key,
    required this.context,
    required this.label,
    this.actionList,
  });

  @override
  double? get titleSpacing => Navigator.canPop(context) ? 5 : super.titleSpacing;

  @override
  Widget? get title => Text(label, style: AppTextStyle.instance.notoSansBold20,);

  @override
  List<Widget>? get actions => actionList;
}
