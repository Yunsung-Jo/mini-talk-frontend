import 'package:flutter/cupertino.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/models/job.dart';
import 'package:minitalk/models/personality.dart';
import 'package:minitalk/repository/friend_repository.dart';

class FriendViewModel with ChangeNotifier {
  final _friend = FriendRepository();

  Future<Friend> createFriend(String name, Job job, Personality personality) async {
    Friend friend = await _friend.createFriend(Friend(
      name: name,
      job: job,
      personality: personality,
    ));
    return friend;
  }
}
