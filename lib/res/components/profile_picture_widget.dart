import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/res/assets.dart';
import 'package:minitalk/res/colors.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? photoUrl;
  final bool bigProfile;

  const ProfilePictureWidget({
    super.key,
    this.photoUrl,
    this.bigProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bigProfile ? 46 : 36,
      height: bigProfile ? 46 : 36,
      decoration: BoxDecoration(
          color: AppColors.serve,
          borderRadius: BorderRadius.circular(bigProfile ? 18 : 15),
          image: photoUrl == null
              ? null
              : DecorationImage(image: NetworkImage(photoUrl!))
      ),
      child: Padding(
        padding: EdgeInsets.all(bigProfile ? 9 : 7),
        child: photoUrl == null
            ? SvgPicture.asset(Assets.userRobot, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),)
            : null,
      ),
    );
  }
}
