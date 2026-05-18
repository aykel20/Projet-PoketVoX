
class PhraseItem {
  final String theme;
  final String fr;
  final Map<String, String> translations;

  const PhraseItem({required this.theme, required this.fr, required this.translations});

  String inLanguage(String language) => translations[language] ?? fr;
}
