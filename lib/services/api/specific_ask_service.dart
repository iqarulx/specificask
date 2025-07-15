import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:specificask/services/api/config.dart';

class SpecificAskService {
  static final String _apiUrl = Config.apiUrl;
  static const String _route = "specific_ask.php";

  static Future<Map<String, dynamic>> addSpecificAsk(
      {required String mobileNumber}) async {
    try {
      final queryParameters = {
        'specific_ask': 1,
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
}
