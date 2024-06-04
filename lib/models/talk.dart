import 'package:minitalk/models/talker.dart';

class Talk {
  int id;
  String text;
  Talker talker;
  DateTime createdDate;

  Talk({
    required this.id,
    required this.text,
    required this.talker,
    required this.createdDate,
  });

  static Talk fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    String text = json["text"].replaceAll("\n", " ");
    Talker talker = Talker.toEnum(json["talker"]);
    DateTime createdDate = DateTime.parse(json["createdDate"]);
    return Talk(id: id, text: text, talker: talker, createdDate: createdDate);
  }
}
