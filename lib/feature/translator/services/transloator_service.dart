import 'dart:developer';

import 'package:translator/configs/core/api_service.dart';
import 'package:translator/feature/translator/model/translator_model.dart';

class TranslatorService {
  final ApiService _apiService = ApiService();

  Future<List<Language>> fetchLanguages() async {
    final data = await _apiService.get('languages');

    return (data['data']['languages'] as List)
        .map((lang) => Language.fromJson(lang))
        .toList();
  }

  Future<String> translateText(String text, String from, String to) async {
    try {
      final data = await _apiService.post({
        'q': text,
        'source': from,
        'target': to,
        'format': 'text',
      });

      log('Response: ${data.toString()}');

      // Ensure the response structure is correct
      if (data['data'] != null &&
          data['data']['translations'] != null &&
          data['data']['translations'].isNotEmpty) {
        return data['data']['translations'][0]['translatedText'];
      } else {
        throw Exception('Unexpected response structure: ${data.toString()}');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Translation failed: $e');
    }
  }
}
