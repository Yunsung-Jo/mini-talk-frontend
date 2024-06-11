import 'package:flutter/material.dart';
import 'package:minitalk/res/components/custom_app_bar.dart';
import 'package:minitalk/utils/routes/routes_name.dart';
import 'package:minitalk/view/home/base_view.dart';
import 'package:minitalk/view/home/chat/chat_list_item.dart';
import 'package:minitalk/view_model/home_view_model.dart';
import 'package:minitalk/view_model/talk_view_model.dart';
import 'package:provider/provider.dart';

class ChatView extends BaseView {
  const ChatView({
    super.key,
    required super.label,
    required super.icon,
    required super.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, label: label,),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final talkViewModel = Provider.of<TalkViewModel>(context);
    return SingleChildScrollView(
      key: const PageStorageKey<String>('chat_view'),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          for (var friend in homeViewModel.getFriends())
            ChatListItem(
              friend: friend,
              onTap: (value) {
                talkViewModel.getTalksAsync(value.id);
                Navigator.pushNamed(
                  context,
                  RoutesName.chat,
                  arguments: {
                    "friend": value,
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
