import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://google-translate1.p.rapidapi.com/language/translate/v2';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': '38107f95d0mshe113d969ee46dd8p1d5160jsn606caa6be4c4',
    'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com',
  };

  Future<dynamic> get(String endpoint) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> post(Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl), // Use baseUrl directly
        headers: {
          ...headers,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      log('Response: ${response.body}');
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        log('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to post data: ${response.body}');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Failed to post data');
    }
  }
}
