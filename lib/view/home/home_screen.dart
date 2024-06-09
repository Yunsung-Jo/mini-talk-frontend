import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/res/assets.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/style/text_style.dart';
import 'package:minitalk/view/home/base_view.dart';
import 'package:minitalk/view/home/chat/chat_view.dart';
import 'package:minitalk/view/home/friend/friend_view.dart';
import 'package:minitalk/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<BaseView> _widgetOptions = [
    const FriendView(key: PageStorageKey('friend_view'), label: "친구", icon: Assets.user, index: 0,),
    const ChatView(key: PageStorageKey('chat_view'), label: "채팅", icon: Assets.messages, index: 1,),
  ];

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(homeViewModel.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _widgetOptions.map((item) {
          return BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: SvgPicture.asset(
                item.icon,
                width: 20,
                colorFilter: ColorFilter.mode(
                  item.index == homeViewModel.selectedIndex
                      ? AppColors.primary
                      : AppColors.lightGray2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            label: item.label,
            tooltip: item.label
          );
        }).toList(),
        currentIndex: homeViewModel.selectedIndex,
        onTap: homeViewModel.setSelectedIndex,
        selectedFontSize: 12,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightGray2,
        selectedLabelStyle: AppTextStyle.instance.notoSans12,
        unselectedLabelStyle: AppTextStyle.instance.notoSans12,
      ),
    );
  }
}
