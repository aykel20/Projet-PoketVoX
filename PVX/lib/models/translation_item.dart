class TranslationItem {
  final String id;
  final String theme;
  final String sourceLanguage;
  final String targetLanguage;
  final String originalText;
  final String translatedText;
  final DateTime createdAt;
  final bool isFavorite;

  const TranslationItem({
    required this.id,
    required this.theme,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.originalText,
    required this.translatedText,
    required this.createdAt,
    this.isFavorite = false,
  });

  TranslationItem copyWith({bool? isFavorite}) {
    return TranslationItem(
      id: id,
      theme: theme,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      originalText: originalText,
      translatedText: translatedText,
      createdAt: createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'theme': theme,
        'sourceLanguage': sourceLanguage,
        'targetLanguage': targetLanguage,
        'originalText': originalText,
        'translatedText': translatedText,
        'createdAt': createdAt.toIso8601String(),
        'isFavorite': isFavorite,
      };

  factory TranslationItem.fromJson(Map<String, dynamic> json) {
    return TranslationItem(
      id: json['id'] as String,
      theme: json['theme'] as String,
      sourceLanguage: json['sourceLanguage'] as String,
      targetLanguage: json['targetLanguage'] as String,
      originalText: json['originalText'] as String,
      translatedText: json['translatedText'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
