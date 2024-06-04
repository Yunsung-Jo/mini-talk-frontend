import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:minitalk/models/talk.dart';
import 'package:minitalk/repository/talk_repository.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TalkViewModel with ChangeNotifier {
  final _talk = TalkRepository();

  static String words = '';

  static SpeechToText speechToText = SpeechToText();
  static FlutterTts flutterTts = FlutterTts();

  Future<Talk> sendTalk(String text) async {
    return await _talk.sendTalk(10, text);
  }

  void init() {
    words = '';
  }
}
