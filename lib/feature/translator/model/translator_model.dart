class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  /// Factory constructor to parse JSON into a Language object
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['language'], // The language code from the API response
      name: json['name'] ??
          json['language'], // Fallback to 'language' if 'name' is null
    );
  }

  /// Method to convert Language object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'language': code,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Language(code: $code, name: $name)';
  }
}
