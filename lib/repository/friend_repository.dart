import 'package:minitalk/data/network/base_api_services.dart';
import 'package:minitalk/data/network/network_api_services.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/repository/database_repository.dart';
import 'package:minitalk/res/tables.dart';
import 'package:minitalk/res/urls.dart';

class FriendRepository extends DatabaseRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  static List<Friend> _friends = [];

  FriendRepository({
    super.table = Tables.friend,
  });

  Future<Friend> createFriend(Friend friend) async {
    try {
      final response = await _apiServices.getPostApiResponse(
        Urls.friendEndPoint,
        friend.toMap(http: true),
      );
      Friend f = Friend.fromJson(response);
      await insert(f);
      _friends.add(f);
      return f;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Friend>> getFriendsAsync() async {
    List<Friend> friends = await rawQuery(
        Friend.fromJsonList,
        """
        SELECT
          f.id,
          f.name,
          f.job,
          f.personality,
          t.text,
          t.createdDate
        FROM ${Tables.friend} AS f
        LEFT JOIN (
          SELECT friendId, MAX(id) AS id
          FROM ${Tables.talk}
          GROUP BY friendId
        ) AS sub ON f.id = sub.friendId
        LEFT JOIN ${Tables.talk} AS t ON f.id = t.friendId AND t.id = sub.id
        ORDER BY
          CASE
            WHEN t.text IS NULL THEN 1 ELSE 0
          END,
          t.id DESC,
          f.id ASC
        """,
    ) as List<Friend>;
    if (friends.isEmpty) {
      try {
        final response = await _apiServices.getGetApiResponse(Urls.friendsEndPoint);
        friends = Friend.fromJsonList(response);
        await insertAll(friends);
      } catch (e) {
        rethrow;
      }
    }
    _friends = friends;
    return _friends;
  }

  List<Friend> getFriends() {
    return _friends;
  }
}
