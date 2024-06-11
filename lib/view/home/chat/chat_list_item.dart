import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/res/components/profile_picture_widget.dart';
import 'package:minitalk/res/padding.dart';
import 'package:minitalk/res/style/decoration_style.dart';
import 'package:minitalk/res/style/text_style.dart';

class ChatListItem extends StatelessWidget {
  final Friend friend;
  final Function(Friend)? onTap;

  const ChatListItem({
    super.key,
    required this.friend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool thisYear = friend.createdDate?.year == DateTime.now().year;
    return InkWell(
      onTap: () => onTap?.call(friend),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: AppPadding.main),
        decoration: AppDecorationStyle.instance.bottomBorder,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const ProfilePictureWidget(bigProfile: true,),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(friend.name, style: AppTextStyle.instance.notoSans15,),
                        const SizedBox(height: 2,),
                        Text(
                          friend.text ?? "대화를 시작할 수 있어요!",
                          style: AppTextStyle.instance.notoSans12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (friend.text != null)
              Text(
                DateFormat("${!thisYear ? "y년 " : ""}M월 d일").format(friend.createdDate!),
                style: AppTextStyle.instance.notoSans12,
              ),
          ],
        ),
      ),
    );
  }
}
