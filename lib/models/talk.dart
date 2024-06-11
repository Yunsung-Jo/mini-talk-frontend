import 'package:minitalk/models/base_model.dart';
import 'package:minitalk/models/talker.dart';

class Talk extends BaseModel {
  int id;
  int friendId;
  String text;
  Talker talker;
  DateTime createdDate;

  Talk({
    this.id = 0,
    required this.friendId,
    required this.text,
    required this.talker,
    required this.createdDate,
  });

  static Talk fromJson(dynamic json, {int? friendId}) {
    return Talk(
        id: json["id"],
        friendId: json["friendId"] ?? friendId,
        text: json["text"].replaceAll("\n", ""),
        talker: Talker.values.byName(json["talker"].toLowerCase()),
        createdDate: DateTime.parse(json["createdDate"]),
    );
  }

  static List<Talk> fromJsonList(dynamic json) =>
      BaseModel.fromJsonList(fromJson, json);

  @override
  Map<String, Object?> toMap({bool http = false}) {
    return {
      if (!http) "id": id,
      if (!http) "friendId": friendId,
      "text": text,
      if (!http) "talker": talker.name.toUpperCase(),
      if (!http) "createdDate": createdDate.toString(),
    };
  }
}
