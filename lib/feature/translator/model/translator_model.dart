class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
        code: json['language'], name: json['name'] ?? json['language']);
  }

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
