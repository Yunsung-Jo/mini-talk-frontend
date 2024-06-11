import 'package:flutter/material.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/res/components/profile_picture_widget.dart';
import 'package:minitalk/res/padding.dart';
import 'package:minitalk/res/style/decoration_style.dart';
import 'package:minitalk/res/style/text_style.dart';

class FriendListItem extends StatelessWidget {
  final String? name;
  final String? photoUrl;
  final Friend? friend;

  const FriendListItem({
    super.key,
    this.name,
    this.photoUrl,
    this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: AppPadding.main),
        decoration: AppDecorationStyle.instance.bottomBorder,
        child: Row(
          children: [
            ProfilePictureWidget(photoUrl: photoUrl,),
            const SizedBox(width: 10,),
            Expanded(
              child: Text(
                name ?? friend!.name,
                style: AppTextStyle.instance.notoSans15,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
