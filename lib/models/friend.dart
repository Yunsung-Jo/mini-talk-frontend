import 'package:minitalk/models/base_model.dart';
import 'package:minitalk/models/job.dart';
import 'package:minitalk/models/personality.dart';

class Friend extends BaseModel {
  int id;
  String name;
  Job job;
  Personality personality;
  String? text;
  DateTime? createdDate;

  Friend({
    this.id = 0,
    required this.name,
    required this.job,
    required this.personality,
    this.text,
    this.createdDate,
  });

  static Friend fromJson(dynamic json) {
    return Friend(
      id: json["id"],
      name: json["name"],
      job: Job.values.byName(json["job"].toLowerCase()),
      personality: Personality.values.byName(json["personality"].toLowerCase()),
      text: json["text"],
      createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    );
  }

  static List<Friend> fromJsonList(dynamic json) =>
      BaseModel.fromJsonList(fromJson, json);

  @override
  Map<String, Object?> toMap({bool http = false}) {
    return {
      if (!http) "id": id,
      "name": name,
      "job": job.name.toUpperCase(),
      "personality": personality.name.toUpperCase(),
    };
  }
}
