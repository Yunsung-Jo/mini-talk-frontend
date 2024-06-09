import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/res/colors.dart';

class ActionButton extends StatelessWidget {
  final Function() onPressed;
  final String icon;
  final int turn;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.turn = 0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: RotatedBox(
        quarterTurns: turn,
        child: SvgPicture.asset(
          icon,
          width: 20,
          colorFilter: const ColorFilter.mode(
            AppColors.text,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
