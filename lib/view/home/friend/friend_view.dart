import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/res/assets.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/components/custom_app_bar.dart';
import 'package:minitalk/view/home/friend/friend_list_item.dart';
import 'package:minitalk/res/components/title_text_widget.dart';
import 'package:minitalk/res/padding.dart';
import 'package:minitalk/utils/routes/routes_name.dart';
import 'package:minitalk/view/home/base_view.dart';
import 'package:minitalk/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class FriendView extends BaseView {
  const FriendView({
    super.key,
    required super.label,
    required super.icon,
    required super.index,
  });

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        label: label,
        actionList: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.friend)
                  .then(homeViewModel.refresh);
            },
            icon: SvgPicture.asset(
              Assets.userAdd,
              width: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.text,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: _body(context, homeViewModel),
    );
  }

  Widget _body(BuildContext context, HomeViewModel homeViewModel) {
    return SingleChildScrollView(
      key: const PageStorageKey<String>('friend_view'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextWidget(title: "프로필", left: AppPadding.main, top: 10,),
          FriendListItem(
            name: homeViewModel.getUser().name,
            photoUrl: homeViewModel.getUser().photoUrl,
          ),
          TitleTextWidget(
            title: "친구 ${homeViewModel.getFriends().length}명",
            left: AppPadding.main,
          ),
          for (var friend in homeViewModel.getFriends())
            FriendListItem(friend: friend,),
        ],
      ),
    );
  }
}
