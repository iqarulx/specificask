import 'dart:convert';
import 'package:specificask/model/profile_model.dart';

import '../../model/posting_model.dart';
import '../others/db.dart';
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

  static Future<List<PostingModel>> fetchPosting() async {
    try {
      final queryParameters = {
        'fetch_postings': 1,
      };
      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['postings'] is List && data['postings'].isNotEmpty) {
          return data['postings']
              .map<PostingModel>((posting) => PostingModel.fromMap(posting))
              .toList();
        }
        return [];
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<ProfileModel> fetchProfile() async {
    try {
      var userDetails = await Db.getData();

      final queryParameters = {
        'fetch_profile': 1,
        'mobile_number': userDetails['mobileNumber'],
      };

      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return ProfileModel.fromMap(data['data']);
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<bool> requestDeleteAccount() async {
    try {
      var userDetails = await Db.getData();

      final queryParameters = {
        'request_delete_account': 1,
        'mobile_number': userDetails['mobileNumber'],
      };
      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        return true;
      } else {
        var data = json.decode(response.body);
        throw data['message'];
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
