import 'package:flutter/material.dart';
import '/screens/screens.dart';
import '/services/services.dart';

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
