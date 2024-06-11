import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/res/assets.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/components/action_button.dart';
import 'package:minitalk/res/components/custom_app_bar.dart';
import 'package:minitalk/res/components/talk_list_widget.dart';
import 'package:minitalk/res/padding.dart';
import 'package:minitalk/view_model/talk_view_model.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Friend friend = arguments["friend"];
    final talkViewModel = Provider.of<TalkViewModel>(context);
    talkViewModel.setFriend(friend);
    talkViewModel.text.addListener(talkViewModel.setSendButtonVisible);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        context: context,
        label: friend.name,
        actionList: [
          ActionButton(
            onPressed: () {

            },
            icon: Assets.phoneFlip,
            turn: 1,
          ),
        ],
      ),
      body: SafeArea(
        child: _body(context, talkViewModel),
      ),
    );
  }

  Widget _body(BuildContext context, TalkViewModel talkViewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TalkListWidget(
          talks: talkViewModel.getTalks(),
          scrollController: talkViewModel.scrollController,
        ),
        Column(
          children: [
            const Divider(color: AppColors.lightGray, height: 0, thickness: 0.5,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: talkViewModel.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.main,),
                    ),
                  ),
                ),
                Visibility(
                  visible: talkViewModel.sendButtonVisible,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: InkWell(
                    onTap: talkViewModel.sendTalk,
                    child: Container(
                      padding: const EdgeInsets.only(left: 17, right: 13),
                      height: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.lightGray,
                      ),
                      child: SvgPicture.asset(
                        Assets.paperPlane,
                        width: 20,
                        colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
