import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:minitalk/models/talk.dart';
import 'package:minitalk/models/talker.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/padding.dart';
import 'package:minitalk/res/style/text_style.dart';

class TalkListWidget extends StatelessWidget {
  final List<Talk> talks;
  final ScrollController scrollController;

  const TalkListWidget({
    super.key,
    required this.talks,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            controller: scrollController,
            itemCount: talks.length,
            itemBuilder: (context, index) {
              Talk talk = talks[index];
              bool isUser = talk.talker == Talker.user;
              return Directionality(
                textDirection: isUser ? TextDirection.rtl : TextDirection.ltr,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: isUser ? 4 : AppPadding.main,
                          right: isUser ? AppPadding.main : 4,
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isUser ? AppColors.serve : AppColors.primary,
                        ),
                        child: Text(
                          talk.text.replaceAll("\n", ""),
                          style: AppTextStyle.instance.notoSans15.apply(
                            color: isUser ? AppColors.text : Colors.white,
                          ),
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        intl.DateFormat("aa h시 m분").format(talk.createdDate)
                            .replaceFirst("AM", "오전")
                            .replaceFirst("PM", "오후"),
                        style: AppTextStyle.instance.notoSans10,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
