import 'package:google_sign_in/google_sign_in.dart';
import 'package:minitalk/data/network/base_api_services.dart';
import 'package:minitalk/data/network/network_api_services.dart';
import 'package:minitalk/models/user.dart';
import 'package:minitalk/res/env/env.dart';
import 'package:minitalk/res/urls.dart';

class AuthRepository {
  static late User _user;
  final BaseApiServices _apiServices = NetworkApiServices();
  final _google = GoogleSignIn(serverClientId: Env.serverClientId);

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

  Future<bool> isSignedIn() async {
    return await _google.isSignedIn();
  }

  Future<String> _googleSignIn() async {
    bool isSignedIn = await this.isSignedIn();
    GoogleSignInAccount? account = isSignedIn
        ? await _google.signInSilently()
        : await _google.signIn();
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
