
class TranslationRecord {
  final String id;
  final String userId;
  final String theme;
  final String sourceLanguage;
  final String targetLanguage;
  final String originalText;
  final String translatedText;
  final DateTime createdAt;
  final bool favorite;

  const TranslationRecord({
    required this.id,
    required this.userId,
    required this.theme,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.originalText,
    required this.translatedText,
    required this.createdAt,
    this.favorite = false,
  });

  TranslationRecord copyWith({bool? favorite}) => TranslationRecord(
    id: id,
    userId: userId,
    theme: theme,
    sourceLanguage: sourceLanguage,
    targetLanguage: targetLanguage,
    originalText: originalText,
    translatedText: translatedText,
    createdAt: createdAt,
    favorite: favorite ?? this.favorite,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'theme': theme,
    'sourceLanguage': sourceLanguage,
    'targetLanguage': targetLanguage,
    'originalText': originalText,
    'translatedText': translatedText,
    'createdAt': createdAt.toIso8601String(),
    'favorite': favorite,
  };

  factory TranslationRecord.fromJson(Map<String, dynamic> json) => TranslationRecord(
    id: json['id'] as String,
    userId: json['userId'] as String,
    theme: json['theme'] as String,
    sourceLanguage: json['sourceLanguage'] as String,
    targetLanguage: json['targetLanguage'] as String,
    originalText: json['originalText'] as String,
    translatedText: json['translatedText'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    favorite: json['favorite'] as bool? ?? false,
  );
}
