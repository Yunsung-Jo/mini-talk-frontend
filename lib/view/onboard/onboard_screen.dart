import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minitalk/res/assets.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/components/illustration_widget.dart';
import 'package:minitalk/res/style/text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    PageController pageController = PageController();
    return Column(
      children: [
        Flexible(
          flex: 8,
          child: PageView(
            controller: pageController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("나만을 위한 AI 친구", style: AppTextStyle.instance.titleBold_25),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SvgPicture.asset(
                            Assets.messages,
                            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text("미니톡", style: AppTextStyle.instance.titleBold_30),
                      ],
                    ),
                  ],
                ),
              ),
              const IllustrationWidget(
                assetName: Assets.onboard1,
                title: "나만의 AI 친구를 만들어보세요!",
                subtitle: "원하는 스타일을 선택할 수 있어요!",
              ),
              const IllustrationWidget(
                assetName: Assets.onboard2,
                title: "AI 친구와 언제든지 대화하세요!",
                subtitle: "언제 어디서든 24시간 대기 중이에요!",
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: SlideEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  dotColor: AppColors.primary.withOpacity(0.2),
                  activeDotColor: AppColors.primary,
                  spacing: 20,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.googleLogo, width: 18,),
                        const SizedBox(width: 12,),
                        Text("Google 계정으로 로그인", style: AppTextStyle.instance.content_16),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(text: "서비스 이용 시작 시 미니톡의 ", style: AppTextStyle.instance.content_12),
                          TextSpan(text: "서비스 이용약관", style: AppTextStyle.instance.contentBold_12),
                          TextSpan(text: "과\n", style: AppTextStyle.instance.content_12),
                          TextSpan(text: "개인정보 처리방침", style: AppTextStyle.instance.contentBold_12),
                          TextSpan(text: "에 동의하시는 것으로 간주합니다.", style: AppTextStyle.instance.content_12),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
