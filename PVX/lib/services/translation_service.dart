class TranslationService {
  static const List<String> themes = [
    'Restaurant',
    'Bus',
    'Magasin',
    'Musée',
    'Hôtel',
    'Urgence',
    'Voyage',
  ];

  static const List<String> languages = [
    'Français',
    'Anglais',
    'Espagnol',
    'Italien',
    'Allemand',
  ];

  Future<String> translate({
    required String text,
    required String theme,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    final cleanedText = text.trim();
    if (cleanedText.isEmpty) return 'Écris une phrase pour obtenir une traduction.';

    final samples = {
      'Restaurant': {
        'Anglais': 'Hello, I would like to order, please.',
        'Espagnol': 'Hola, me gustaría pedir, por favor.',
        'Italien': 'Buongiorno, vorrei ordinare, per favore.',
        'Allemand': 'Hallo, ich möchte bitte bestellen.',
        'Français': 'Bonjour, je voudrais commander, s’il vous plaît.',
      },
      'Bus': {
        'Anglais': 'Hello, does this bus go to the city centre?',
        'Espagnol': 'Hola, ¿este autobús va al centro?',
        'Italien': 'Buongiorno, questo autobus va in centro?',
        'Allemand': 'Hallo, fährt dieser Bus ins Stadtzentrum?',
        'Français': 'Bonjour, ce bus va-t-il au centre-ville ?',
      },
      'Magasin': {
        'Anglais': 'Hello, how much does this cost?',
        'Espagnol': 'Hola, ¿cuánto cuesta esto?',
        'Italien': 'Buongiorno, quanto costa questo?',
        'Allemand': 'Hallo, wie viel kostet das?',
        'Français': 'Bonjour, combien cela coûte-t-il ?',
      },
      'Musée': {
        'Anglais': 'Hello, where can I buy a ticket?',
        'Espagnol': 'Hola, ¿dónde puedo comprar una entrada?',
        'Italien': 'Buongiorno, dove posso comprare un biglietto?',
        'Allemand': 'Hallo, wo kann ich eine Eintrittskarte kaufen?',
        'Français': 'Bonjour, où puis-je acheter un billet ?',
      },
      'Hôtel': {
        'Anglais': 'Hello, I have a reservation.',
        'Espagnol': 'Hola, tengo una reserva.',
        'Italien': 'Buongiorno, ho una prenotazione.',
        'Allemand': 'Hallo, ich habe eine Reservierung.',
        'Français': 'Bonjour, j’ai une réservation.',
      },
      'Urgence': {
        'Anglais': 'I need help, please.',
        'Espagnol': 'Necesito ayuda, por favor.',
        'Italien': 'Ho bisogno di aiuto, per favore.',
        'Allemand': 'Ich brauche bitte Hilfe.',
        'Français': 'J’ai besoin d’aide, s’il vous plaît.',
      },
      'Voyage': {
        'Anglais': 'Hello, where is the train station?',
        'Espagnol': 'Hola, ¿dónde está la estación de tren?',
        'Italien': 'Buongiorno, dov’è la stazione ferroviaria?',
        'Allemand': 'Hallo, wo ist der Bahnhof?',
        'Français': 'Bonjour, où est la gare ?',
      },
    };

    final lower = cleanedText.toLowerCase();
    final shouldUseSample = lower.contains('bonjour') ||
        lower.contains('hello') ||
        lower.contains('combien') ||
        lower.contains('commander') ||
        lower.contains('aide') ||
        lower.contains('gare') ||
        lower.contains('bus');

    if (shouldUseSample) {
      return samples[theme]?[targetLanguage] ?? '[$targetLanguage] $cleanedText';
    }

    return '[$targetLanguage • $theme] $cleanedText';
  }
}
