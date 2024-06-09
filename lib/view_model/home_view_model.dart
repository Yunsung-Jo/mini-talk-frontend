import 'package:flutter/cupertino.dart';
import 'package:minitalk/models/friend.dart';
import 'package:minitalk/models/user.dart';
import 'package:minitalk/repository/auth_repository.dart';
import 'package:minitalk/repository/friend_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _auth = AuthRepository();
  final _friend = FriendRepository();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void refresh(Object? value) {
    notifyListeners();
  }

  void setSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  User getUser() {
    return _auth.getUser();
  }

  List<Friend> getFriends() {
    return _friend.getFriends();
  }
}
