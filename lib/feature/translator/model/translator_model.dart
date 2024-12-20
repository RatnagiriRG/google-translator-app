class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['language'],
      name: json['name'] ?? json['language'],
    );
  }
}
