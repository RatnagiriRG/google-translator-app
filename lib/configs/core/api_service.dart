import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://deep-translate1.p.rapidapi.com/language/translate/v2';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': '38107f95d0mshe113d969ee46dd8p1d5160jsn606caa6be4c4',
    'X-RapidAPI-Host': 'deep-translate1.p.rapidapi.com',
    'Content-Type': 'application/json', // Updated to JSON content type
  };

  /// GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );

      // log('GET Response Status: ${response.statusCode}');
      // log('GET Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.body}');
      }
    } catch (e) {
      // log('GET Exception: $e');
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

      // log('POST Response Status: ${response.statusCode}');
      // log('POST Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // log('POST Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to post data: ${response.body}');
      }
    } catch (e) {
      // log('POST Exception: $e');
      throw Exception('Failed to post data');
    }
  }
}
