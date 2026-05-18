
import 'phrasebook_service.dart';

class AiTranslationService {
  final PhrasebookService phrasebook = PhrasebookService();

  Future<String> translate({
    required String text,
    required String theme,
    required String targetLanguage,
  }) async {
    final clean = text.trim();
    if (clean.isEmpty) return 'Écris une phrase à traduire.';

    final exact = phrasebook.byTheme(theme).where((p) => p.fr.toLowerCase() == clean.toLowerCase()).toList();
    if (exact.isNotEmpty) return exact.first.inLanguage(targetLanguage);

    final lower = clean.toLowerCase();
    for (final phrase in phrasebook.byTheme(theme)) {
      final words = phrase.fr.toLowerCase().split(RegExp(r'[^a-zà-ÿ]+')).where((w) => w.length > 3);
      if (words.any((word) => lower.contains(word))) return phrase.inLanguage(targetLanguage);
    }

    final prefix = {
      'Anglais': 'AI translation',
      'Espagnol': 'Traducción IA',
      'Italien': 'Traduzione IA',
      'Allemand': 'KI-Übersetzung',
    }[targetLanguage] ?? 'Traduction IA';

    return '$prefix • $theme : $clean';
  }
}
