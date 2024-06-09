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
    if (_friends.isNotEmpty) {
      return _friends;
    }
    List<Friend> friends = await find(Friend.fromJsonList) as List<Friend>;
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
