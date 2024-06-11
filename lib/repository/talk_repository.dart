import 'package:minitalk/data/network/base_api_services.dart';
import 'package:minitalk/data/network/network_api_services.dart';
import 'package:minitalk/models/talk.dart';
import 'package:minitalk/repository/database_repository.dart';
import 'package:minitalk/res/tables.dart';
import 'package:minitalk/res/urls.dart';

class TalkRepository extends DatabaseRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  TalkRepository({
    super.table = Tables.talk,
  });

  Future<Talk> sendTalk(Talk userTalk) async {
    try {
      final response = await _apiServices.getPostApiResponse(
        "${Urls.talkEndPoint}/${userTalk.friendId}",
        {"text": userTalk.text },
      );
      Talk talk = Talk.fromJson(response, friendId: userTalk.friendId,);
      userTalk.id = talk.id - 1;
      await insert(userTalk);
      await insert(talk);
      return talk;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Talk>> getTalksAsync(int friendId) async {
    return await find(
      Talk.fromJsonList,
      where: "friendId = ?",
      whereArgs: [friendId,],
      orderBy: "id DESC",
    ) as List<Talk>;
  }
}
