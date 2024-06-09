import 'package:flutter/cupertino.dart';
import 'package:minitalk/models/user.dart';
import 'package:minitalk/repository/auth_repository.dart';
import 'package:minitalk/repository/friend_repository.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();
  final _friend = FriendRepository();

  bool _loading = false;
  get loading => _loading;

  bool _register = false;
  get register => _register;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setRegister(bool value) {
    _register = value;
    notifyListeners();
  }

  Future<bool> isSignedIn() async {
    return await _auth.isSignedIn();
  }

  Future<bool> signIn() async {
    setLoading(true);
    return _auth.signIn().then((value) async {
      if ((await _friend.getFriendsAsync()).isEmpty) {
        _setRegister(true);
      }
      setLoading(false);
      return value;
    }).onError((error, stackTrace) {
      setLoading(false);
      return false;
    });
  }

  User getUser() {
    return _auth.getUser();
  }
}
