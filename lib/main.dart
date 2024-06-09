import 'package:flutter/material.dart';
import 'package:minitalk/utils/routes/routes.dart';
import 'package:minitalk/utils/routes/routes_name.dart';
import 'package:minitalk/view_model/auth_view_model.dart';
import 'package:minitalk/view_model/friend_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => FriendViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.onboard,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
