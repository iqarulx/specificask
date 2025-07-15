import 'package:flutter/material.dart';

import '../../screens/auth/login.dart';
import '../../screens/screens/index.dart';
import '../../services/others/db.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  Widget? _homeWidget;

  bool get isLoggedIn => _isLoggedIn;
  Widget? get homeWidget => _homeWidget;

  Future<void> checkLoginStatus() async {
    var isLogin = await Db.checkLogin();

    if (isLogin) {
      _homeWidget = const Index();
    } else {
      _homeWidget = const Login();
    }

    _isLoggedIn = true;
    notifyListeners();
  }
}
