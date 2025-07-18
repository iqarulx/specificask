import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/model/model.dart';

class Db {
  Db._internal();

  static final Db _instance = Db._internal();

  factory Db() {
    return _instance;
  }

  static Future<SharedPreferences> connect() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> checkLogin() async {
    var cn = await connect();
    bool? r = cn.getBool('login');
    return r ?? false;
  }

  static Future setLogin({required UserModel model}) async {
    var cn = await connect();
    cn.setString('user', json.encode(model.toMap()));
    cn.setBool('login', true);
  }

  static Future<Map<String, dynamic>> getData() async {
    var cn = await connect();
    return cn.getString('user') != null
        ? json.decode(cn.getString('user')!)
        : null;
  }

  static Future<bool> clearDb() async {
    var cn = await connect();
    return cn.clear();
  }
}
