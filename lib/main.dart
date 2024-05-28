import 'package:flutter/material.dart';
import 'package:minitalk/utils/routes/routes.dart';
import 'package:minitalk/utils/routes/routes_name.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.onboard,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
