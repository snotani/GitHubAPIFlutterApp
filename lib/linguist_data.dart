class LanguageInfo {
  final String language;

  LanguageInfo.fromJson(Map<String, dynamic> json)
      : language = json['quote'];
}

