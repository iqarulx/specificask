import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specificask/app/src/app_utils.dart';

import '../../screens/ui/splash.dart';
import '../../theme/theme.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthProvider()..checkLoginStatus())
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: "Specific Task",
            theme: AppTheme.appTheme,
            home: authProvider.isLoggedIn
                ? authProvider.homeWidget ?? Container()
                : const Splash(),
          );
        },
      ),
    );
  }
}
