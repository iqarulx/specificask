import 'package:flutter/material.dart';
import '/screens/screens.dart';
import '/services/services.dart';

logout(context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const CDialog(
      title: "Logout",
      content: "Are you sure want to logout?",
    ),
  ).then((value) async {
    if (value != null && value) {
      Navigator.pop(context);
      Db.clearDb();
      if (Navigator.of(context).mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
        Snackbar.showSnackBar(context, content: "Logout Successfully");
      }
    }
  });
}
