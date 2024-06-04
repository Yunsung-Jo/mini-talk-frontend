import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minitalk/models/talk.dart';
import 'package:minitalk/models/talker.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/style/text_style.dart';
import 'package:minitalk/view_model/talk_view_model.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late Timer _timer;
  int _seconds = 0;

  static bool isTalk = false;
  static bool isFinish = false;
  static late _CallScreenState state;



  List<Talk> chat = [];
  ScrollController controller = ScrollController();
  TalkViewModel viewModel = TalkViewModel();
  bool bottomFlag = false;

  @override
  void initState() {
    super.initState();
    isFinish = false;
    state = this;

    setTimer();
    initSTT();
  }

  void setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.setState(() {
        _seconds++;
      });
    });
  }

  void initSTT() async {
    TalkViewModel.flutterTts.setLanguage("ko-KR");
    bool available = await TalkViewModel.speechToText.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    if (available) {
      startListening();
    }
  }

  void startListening() async {
    final options = SpeechListenOptions(
        onDevice: false,
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true);
    TalkViewModel.speechToText.listen(
      onResult: resultListener,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 30),
      localeId: "ko_KR",
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
  }

  void resultListener(SpeechRecognitionResult result) async {
    state.setState(() {
      TalkViewModel.words = result.recognizedWords;
      debugPrint(TalkViewModel.words);
    });
    bool isEnd = result.finalResult;
    isTalk = true;
    if (isEnd && !isFinish && TalkViewModel.words.trim().isNotEmpty) {
      TalkViewModel.speechToText.cancel();
      await Future.delayed(const Duration(seconds: 1));
      String c = result.recognizedWords;
      state.setState(() {
        chat.add(Talk(
          id: 0,
          text: c,
          talker: Talker.user,
          createdDate: DateTime.now(),
        ));
        bottomFlag = true;
      });


      await TalkViewModel.flutterTts.awaitSpeakCompletion(true);

      TalkViewModel talkViewModel = TalkViewModel();
      Talk t = await talkViewModel.sendTalk(c);
      setState(() {
        chat.add(t);
        bottomFlag = true;
      });

      print(t.text);
      await TalkViewModel.flutterTts.speak(removeEmojis(t.text));
      isTalk = false;
      startListening();
    }
  }

  String removeEmojis(String input) {
    final emojiRegex = RegExp(
      r'[\u{1F600}-\u{1F64F}' // Emoticons
      r'\u{1F300}-\u{1F5FF}' // Misc Symbols and Pictographs
      r'\u{1F680}-\u{1F6FF}' // Transport and Map
      r'\u{1F700}-\u{1F77F}' // Alchemical Symbols
      r'\u{1F780}-\u{1F7FF}' // Geometric Shapes Extended
      r'\u{1F800}-\u{1F8FF}' // Supplemental Arrows-C
      r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
      r'\u{1FA00}-\u{1FA6F}' // Chess Symbols
      r'\u{1FA70}-\u{1FAFF}' // Symbols and Pictographs Extended-A
      r'\u{2600}-\u{26FF}'   // Miscellaneous Symbols
      r'\u{2700}-\u{27BF}'   // Dingbats
      r'\u{FE00}-\u{FE0F}'   // Variation Selectors
      r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
      ']+',
      unicode: true,
    );
    return input.replaceAll(emojiRegex, '');
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint('error: ${error.errorMsg}');
  }

  void statusListener(String status) async {
    debugPrint('status: $status $isFinish');
    if (status == 'notListening' && !isFinish && !isTalk) {
      await Future.delayed(const Duration(milliseconds: 500));
      startListening();
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose');
    TalkViewModel.flutterTts.stop();
    isFinish = true;
    _timer.cancel();
    TalkViewModel.speechToText.cancel();
  }

  void callEnd() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _body(context),
        ),
      ),
    );
  }


  double level = 0.0;
  void soundLevelListener(double l) {
    setState(() {
      level = l;
    });
  }















  Widget _body(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 7,
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    height: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("철수", style: AppTextStyle.instance.notoSansBold20,)
                          ],
                        ),
                        Text('${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}', style: AppTextStyle.instance.notoSans12,),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: controller,
                      itemCount: chat.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (bottomFlag && chat.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            controller.animateTo(controller.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                          });
                          bottomFlag = false;
                        }
                        return Row(
                          mainAxisAlignment: chat[index].talker == Talker.user ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                              padding: const EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: index == chat.length - 1 ? 0 : 10),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                color: chat[index].talker == Talker.user ? AppColors.serve : AppColors.primary,
                              ),
                              child: Text(chat[index].text, style: AppTextStyle.instance.notoSans15.apply(
                                color: chat[index].talker == Talker.user ? AppColors.text : Colors.white,
                              ),),
                            ),),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
        Flexible(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(TalkViewModel.words, style: AppTextStyle.instance.notoSans15, overflow: TextOverflow.ellipsis,),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .26,
                            spreadRadius: level * 1.5,
                            color: Colors.black.withOpacity(.05))
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: MaterialButton(
            onPressed: () {

            },
            color: AppColors.red,
            textColor: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            child: const Icon(
              Icons.call_end,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }
}
