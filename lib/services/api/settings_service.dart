import 'dart:convert';
import 'config.dart';
import 'package:http/http.dart' as http;

class SettingsService {
  static final String _apiUrl = Config.apiUrl;
  static const String _route = "settings.php";

  static Future<String> fetchSpecificAskDay() async {
    try {
      final queryParameters = {
        'fetch_specific_ask_day': 1,
      };
      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['specific_ask_day'];
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
