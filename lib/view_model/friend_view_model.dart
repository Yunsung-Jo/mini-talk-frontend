import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/models/job.dart';
import 'package:minitalk/models/personality.dart';
import 'package:minitalk/repository/friend_repository.dart';

class FriendViewModel with ChangeNotifier {
  final _friend = FriendRepository();

  bool _loading = false;
  get loading => _loading;

  final TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  Job _job = Job.student;
  Job get job => _job;

  Personality _personality = Personality.extroversion;
  Personality get personality => _personality;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setJob(Job job) {
    _job = job;
    notifyListeners();
  }

  void setPersonality(Personality personality) {
    _personality = personality;
    notifyListeners();
  }

  Future<bool> createFriend() async {
    setLoading(true);
    return await _friend.createFriend(Friend(
      name: name.text,
      job: job,
      personality: personality,
    )).then((value) {
      return true;
    }).onError((error, stackTrace) {
      setLoading(false);
      return false;
    });
  }
}
