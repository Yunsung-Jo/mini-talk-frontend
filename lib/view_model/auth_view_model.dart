import 'package:flutter/cupertino.dart';
import 'package:minitalk/repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loading = false;
  get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> signIn() async {
    setLoading(true);
    return _auth.signIn().then((value) {
      setLoading(false);
      return value;
    }).onError((error, stackTrace) {
      setLoading(false);
      return false;
    });
  }
}
