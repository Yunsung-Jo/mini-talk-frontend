import 'package:google_sign_in/google_sign_in.dart';
import 'package:minitalk/data/network/base_api_services.dart';
import 'package:minitalk/data/network/network_api_services.dart';
import 'package:minitalk/models/user.dart';
import 'package:minitalk/res/env/env.dart';
import 'package:minitalk/res/urls.dart';

class AuthRepository {
  late User _user;
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<bool> signIn() async {
    try {
      String idToken = await _googleSignIn();
      final response = await _apiServices.getPostApiResponse(Urls.loginEndPoint, {
        "idToken": idToken,
      });
      response as String;
      if (response.isNotEmpty) {
        _apiServices.setAuthorization(response);
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _googleSignIn() async {
    GoogleSignInAccount? account = await GoogleSignIn(
      serverClientId: Env.serverClientId,
    ).signIn();
    try {
      _user = User(name: account!.displayName!, photoUrl: account.photoUrl);
      GoogleSignInAuthentication authentication = await account.authentication;
      return authentication.idToken!;
    } catch (e) {
      rethrow;
    }
  }

  User getUser() {
    return _user;
  }
}
