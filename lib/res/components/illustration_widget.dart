import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/res/style/text_style.dart';

class IllustrationWidget extends StatelessWidget {
  final String assetName;
  final String title;
  final String subtitle;

  const IllustrationWidget({
    super.key,
    required this.assetName,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(assetName),
        const SizedBox(height: 50,),
        Text(title, style: AppTextStyle.instance.notoSansBold20),
        const SizedBox(height: 10,),
        Text(subtitle, style: AppTextStyle.instance.notoSans15),
      ],
    );
  }
}
