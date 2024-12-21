import 'package:flutter/material.dart';
import 'package:translator/configs/routes/routes_name.dart';
import 'package:translator/feature/translator/model/translator_model.dart';
import 'package:translator/feature/translator/services/transloator_service.dart';

class TranslatorViewModel extends ChangeNotifier {
  final TranslatorService _translatorService = TranslatorService();

  final TextEditingController textEditingController = TextEditingController();

  List<Language> _languages = [];
  List<Language> _filteredLanguages = [];
  Language? _fromLanguage;
  Language? _toLanguage;
  String _inputText = '';
  String _translatedText = '';
  String _queryText = '';
  bool _isLoading = true;
  int _characterCount = 0;

  List<Language> get languages => _languages;
  List<Language> get filteredLanguages => _filteredLanguages;
  Language? get fromLanguage => _fromLanguage;
  Language? get toLanguage => _toLanguage;
  String get inputText => _inputText;
  String get translatedText => _translatedText;
  bool get isLoading => _isLoading;
  String get queryText => _queryText;
  int get characterCount => _characterCount;
  int get translatedTextLetterCount =>
      _translatedText.replaceAll(RegExp(r'\s+'), '').length;

  /// Load available languages and navigate to translator page
  Future<void> loadLanguages(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _languages = await _translatorService.fetchLanguages();
      _filteredLanguages = List.from(_languages);

      if (_languages.isNotEmpty) {
        Navigator.of(context).pushReplacementNamed(RoutesName.translatorPage);
      }
    } catch (error) {
      debugPrint('Error loading languages: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterLanguages(String query) {
    _queryText = query;
    if (query.isEmpty) {
      _filteredLanguages = List.from(_languages);
    } else {
      _filteredLanguages = _languages
          .where(
            (lang) => lang.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void selectFromLanguage(Language language) {
    _fromLanguage = language;
    notifyListeners();
  }

  void selectToLanguage(Language language) {
    _toLanguage = language;
    notifyListeners();
  }

  void swapLanguages() {
    final tempLanguage = _fromLanguage;
    _fromLanguage = _toLanguage;
    _toLanguage = tempLanguage;
    notifyListeners();
  }

  void updateCharacterCount(String text) {
    if (text.length > 2300) {
      _inputText = text.substring(0, 2300);
    } else {
      _inputText = text;
    }
    _characterCount = _inputText.length;

    textEditingController.value = TextEditingValue(
      text: _inputText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _characterCount),
      ),
    );
    translate(text);
    notifyListeners();
  }

  Future<void> translate(String text) async {
    if (_fromLanguage == null || _toLanguage == null || text.isEmpty) {
      _translatedText = 'Please select languages and enter text to translate.';
      notifyListeners();
      return;
    }

    _inputText = text;
    _translatedText = 'Translating...';
    notifyListeners();

    try {
      _translatedText = await _translatorService.translateText(
        text,
        _fromLanguage!.code,
        _toLanguage!.code,
      );
    } catch (error) {
      _translatedText = 'Error: Failed to translate. Please try again later.';
      debugPrint('Error translating text: $error');
    } finally {
      notifyListeners();
    }
  }

  void clearFilter() {
    _filteredLanguages = List.from(_languages);
    _queryText = '';
    notifyListeners();
  }
}
