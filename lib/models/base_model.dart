abstract class BaseModel {
  Map<String, Object?> toMap({bool http});

  static List<T> fromJsonList<T>(Function(dynamic) fromJson, dynamic json) {
    if (json.length == 0) {
      return List.empty();
    }
    List<T> list = [];
    for (var item in json) {
      list.add(fromJson.call(item));
    }
    return list;
  }
}
