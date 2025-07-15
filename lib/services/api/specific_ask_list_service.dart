import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:specificask/model/specific_ask_model.dart';
import 'package:specificask/services/api/config.dart';
import 'package:specificask/services/others/db.dart';

import '../../model/my_specific_ask_model.dart';

class SpecificAskListService {
  static final String _apiUrl = Config.apiUrl;
  static const String _route = "specific_ask_list.php";

  static Future<List<SpecificAskModel>> fetchSpecificAsks(
      {required String fromDate, required String toDate}) async {
    try {
      var userDetails = await Db.getData();

      final queryParameters = {
        'fetch_specific_ask_list': 1,
        'mobile_number': userDetails['mobileNumber'],
      };

      if (fromDate.isNotEmpty) {
        queryParameters['from_date'] = fromDate;
      }

      if (toDate.isNotEmpty) {
        queryParameters['to_date'] = toDate;
      }

      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if ((data['data']['specific_ask_list'] as List).isNotEmpty) {
          List<SpecificAskModel> specificAskList = [];
          for (var specificAsk in data['data']['specific_ask_list']) {
            specificAskList.add(SpecificAskModel.fromMap(specificAsk));
          }
          return specificAskList;
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

  static Future<Map<String, dynamic>> connect({required String id}) async {
    try {
      var userDetails = await Db.getData();

      final queryParameters = {
        'specific_id': id,
        'mobile_number': userDetails['mobileNumber'],
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

  static Future<List<MySpecificAskModel>> fetchMySpecificAsks(
      {required String fromDate, required String toDate}) async {
    try {
      var userDetails = await Db.getData();

      final queryParameters = {
        'fetch_my_request': 1,
        'mobile_number': userDetails['mobileNumber'],
      };

      if (fromDate.isNotEmpty) {
        queryParameters['from_date'] = fromDate;
      }

      if (toDate.isNotEmpty) {
        queryParameters['to_date'] = toDate;
      }

      final uri = Uri.parse("$_apiUrl/$_route");

      final response = await http.post(uri, body: json.encode(queryParameters));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if ((data['data']['my_specific_ask_list'] as List).isNotEmpty) {
          List<MySpecificAskModel> specificAskList = [];
          for (var specificAsk in data['data']['my_specific_ask_list']) {
            specificAskList.add(MySpecificAskModel.fromMap(specificAsk));
          }
          return specificAskList;
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

  static Future<Map<String, dynamic>> convertToBusiness(
      {required String id, required bool checkValue}) async {
    try {
      final queryParameters = {
        'convert_to_business': id,
        'check_value': checkValue,
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
