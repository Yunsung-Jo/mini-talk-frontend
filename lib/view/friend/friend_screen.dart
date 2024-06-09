import 'package:flutter/material.dart';
import 'package:minitalk/models/job.dart';
import 'package:minitalk/models/personality.dart';
import 'package:minitalk/res/components/custom_app_bar.dart';
import 'package:minitalk/res/components/dropdown_widget.dart';
import 'package:minitalk/res/style/decoration_style.dart';
import 'package:minitalk/res/style/text_style.dart';
import 'package:minitalk/utils/routes/routes_name.dart';
import 'package:minitalk/view_model/friend_view_model.dart';
import 'package:provider/provider.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, label: "친구 추가",),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final friendViewModel = Provider.of<FriendViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getHint("이름"),
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: friendViewModel.name,
                    maxLength: 20,
                    decoration: AppDecorationStyle.instance.lightGray.applyDefaults(const InputDecorationTheme(
                      contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 16),
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "친구의 이름을 입력해주세요";
                      }
                      return null;
                    },
                  ),
                ),
                _getHint("직업"),
                DropdownWidget(
                  value: friendViewModel.job,
                  items: Job.values,
                  onChanged: friendViewModel.setJob,
                ),
                _getHint("성격"),
                DropdownWidget(
                  value: friendViewModel.personality,
                  items: Personality.values,
                  onChanged: friendViewModel.setPersonality,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10, bottom: 30),
          child: ElevatedButton(
            onPressed: () {
              if (!friendViewModel.loading) {
                if (formKey.currentState!.validate()) {
                  friendViewModel.createFriend().then((value) {
                    if (value) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacementNamed(context, RoutesName.home);
                      }
                    }
                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16)
            ),
            child: Text("완료", style: AppTextStyle.instance.notoSans15,),
          ),
        ),
      ],
    );
  }

  Widget _getHint(String hint) {
    return Column(
      children: [
        const SizedBox(height: 30,),
        Text(hint, style: AppTextStyle.instance.notoSans12,),
        const SizedBox(height: 5,),
      ],
    );
  }
}
