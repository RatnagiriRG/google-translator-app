import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translator/configs/constants/app_constants.dart';

class ApiService {
  static const String baseUrl =
      'https://deep-translate1.p.rapidapi.com/language/translate/v2';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': AppConstants.rapidAPIKey,
    'X-RapidAPI-Host': 'deep-translate1.p.rapidapi.com',
    'Content-Type': 'application/json',
  };

  /// GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  /// POST request
  Future<dynamic> post(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to post data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to post data');
    }
  }
}
