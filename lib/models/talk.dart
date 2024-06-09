import 'package:minitalk/models/talker.dart';

class Talk {
  int id;
  int friendId;
  String text;
  Talker talker;
  DateTime createdDate;

  Talk({
    required this.id,
    required this.friendId,
    required this.text,
    required this.talker,
    required this.createdDate,
  });
}
