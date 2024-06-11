import 'package:flutter/cupertino.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/models/talk.dart';
import 'package:minitalk/models/talker.dart';
import 'package:minitalk/repository/talk_repository.dart';

class TalkViewModel with ChangeNotifier {
  final _talk = TalkRepository();

  late Friend _friend;
  final List<Talk> _talks = [];

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final TextEditingController _text = TextEditingController();
  TextEditingController get text => _text;

  bool _sendButtonVisible = false;
  bool get sendButtonVisible => _sendButtonVisible;

  void setFriend(Friend friend) {
    _friend = friend;
  }

  void setSendButtonVisible() {
    if (_sendButtonVisible != _text.text.isNotEmpty) {
      _sendButtonVisible = _text.text.isNotEmpty;
      notifyListeners();
    }
  }

  Future<List<Talk>> getTalksAsync(int friendId) async {
    _talks.clear();
    List<Talk> talks = await _talk.getTalksAsync(friendId);
    _talks.addAll(talks);
    notifyListeners();
    return talks;
  }

  List<Talk> getTalks() {
    return _talks;
  }

  Future<void> sendTalk() async {
    Talk userTalk = Talk(
      friendId: _friend.id,
      text: _text.text,
      talker: Talker.user,
      createdDate: DateTime.now(),
    );
    _text.text = "";
    _talks.insert(0, userTalk);
    _scroll();
    await _talk.sendTalk(userTalk).then((value) {
      _talks.insert(0, value);
      notifyListeners();
      _scroll();
    });
  }

  void _scroll() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}
