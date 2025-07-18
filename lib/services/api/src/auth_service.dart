import 'dart:convert';
import 'package:http/http.dart' as http;
import '/model/model.dart';
import '/services/services.dart';

class AuthService {
  static final String _apiUrl = Config.apiUrl;
  static const String _route = "auth.php";

  static Future<Map<String, dynamic>> verifyMobileNumber(
      {required String mobileNumber}) async {
    try {
      final queryParameters = {
        'verify_mobile_number': 1,
        'mobile_number': mobileNumber
      };
      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<UserModel> getUserDetails(
      {required String mobileNumber}) async {
    try {
      final queryParameters = {
        'get_user_details': 1,
        'mobile_number': mobileNumber
      };
      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return UserModel.fromMap(data['data']);
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<Map<String, dynamic>> requestForNewAccount(
      {required Map<String, dynamic> data}) async {
    try {
      data['request_for_new_account'] = 1;
      final queryParameters = data;
      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
