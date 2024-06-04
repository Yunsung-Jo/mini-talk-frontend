import 'package:minitalk/data/network/base_api_services.dart';
import 'package:minitalk/data/network/network_api_services.dart';
import 'package:minitalk/models/talk.dart';
import 'package:minitalk/res/urls.dart';

class TalkRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<Talk> sendTalk(int id, String text) async {
    try {
      _apiServices.setAuthorization("");
      final response = await _apiServices.getPostApiResponse("${Urls.talkEndPoint}/$id", {
        "text": text,
      });
      Talk talk = Talk.fromJson(response);
      return talk;
    } catch (e) {
      rethrow;
    }
  }
}
