import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  final TextStyle style;

  const TitleTextWidget({
    super.key,
    required this.title,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        Text(title, style: style,),
        const SizedBox(height: 5,),
      ],
    );
  }
}
