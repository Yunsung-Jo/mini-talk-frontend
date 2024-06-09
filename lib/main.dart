import 'package:flutter/material.dart';
import 'package:minitalk/utils/routes/routes.dart';
import 'package:minitalk/utils/routes/routes_name.dart';
import 'package:minitalk/view_model/auth_view_model.dart';
import 'package:minitalk/view_model/friend_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthViewModel authViewModel = AuthViewModel();
  bool isSignedIn = await authViewModel.isSignedIn();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authViewModel),
        ChangeNotifierProvider(create: (_) => FriendViewModel()),
      ],
      child: App(isSignedIn: isSignedIn,),
    ),
  );
}

class App extends StatelessWidget {
  final bool isSignedIn;

  const App({
    super.key,
    this.isSignedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isSignedIn ? RoutesName.home : RoutesName.onboard,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
