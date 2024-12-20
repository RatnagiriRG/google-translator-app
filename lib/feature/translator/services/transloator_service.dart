import 'package:translator/configs/core/api_service.dart';
import 'package:translator/feature/translator/model/translator_model.dart';

class TranslatorService {
  final ApiService _apiService = ApiService();

  /// Fetch supported languages
  Future<List<Language>> fetchLanguages() async {
    try {
      final data = await _apiService.get('languages');
      return (data['languages'] as List)
          .map((lang) => Language.fromJson(lang))
          .toList();
    } catch (e) {
      throw Exception('Failed to load languages');
    }
  }

  /// Translate text
  Future<String> translateText(String text, String from, String to) async {
    try {
      final body = {
        'q': text,
        'source': from,
        'target': to,
      };

      final data = await _apiService.post(body);
      if (data['data'] != null &&
          data['data']['translations'] != null &&
          data['data']['translations'] is Map &&
          data['data']['translations']['translatedText'] != null) {
        return data['data']['translations']['translatedText'];
      } else {
        throw Exception('Unexpected response structure: ${data.toString()}');
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
