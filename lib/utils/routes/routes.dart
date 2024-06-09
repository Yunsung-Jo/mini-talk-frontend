import 'package:flutter/material.dart';
import 'package:minitalk/utils/routes/routes_name.dart';
import 'package:minitalk/view/friend/friend_screen.dart';
import 'package:minitalk/view/home/home_screen.dart';
import 'package:minitalk/view/onboard/onboard_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.onboard:
        return MaterialPageRoute(builder: (context) => const OnboardScreen());
      case RoutesName.friend:
        return MaterialPageRoute(builder: (context) => const FriendScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
