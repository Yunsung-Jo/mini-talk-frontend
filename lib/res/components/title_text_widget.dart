import 'package:flutter/material.dart';
import 'package:minitalk/res/style/text_style.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  final double left;
  final double top;
  final double bottom;

  const TitleTextWidget({
    super.key,
    required this.title,
    this.left = 0,
    this.top = 30,
    this.bottom = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        bottom: bottom,
      ),
      child: Text(title, style: AppTextStyle.instance.notoSans12,),
    );
  }
}
