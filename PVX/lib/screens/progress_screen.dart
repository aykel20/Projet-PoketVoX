import 'package:flutter/material.dart';
import '../models/translation_item.dart';
import '../widgets/app_card.dart';
import '../widgets/stat_tile.dart';

class ProgressScreen extends StatelessWidget {
  final List<TranslationItem> history;
  const ProgressScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    const goal = 20;
    final total = history.length;
    final progress = (total / goal).clamp(0.0, 1.0).toDouble();
    final favorites = history.where((item) => item.isFavorite).length;
    final practicedLanguages = history.map((item) => item.targetLanguage).toSet().length;

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('Suivi d’apprentissage', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('Objectif : pratiquer 20 phrases utiles.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 18),
        AppCard(
          color: const Color(0xFFEDEAFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [const Expanded(child: Text('Progression globale', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900))), Text('$total/$goal')]),
              const SizedBox(height: 14),
              LinearProgressIndicator(value: progress, minHeight: 14, borderRadius: BorderRadius.circular(20)),
              const SizedBox(height: 14),
              Text(_motivation(total)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        StatTile(icon: Icons.bookmark_added, title: 'Phrases favorites', value: '$favorites', color: Colors.orange),
        const SizedBox(height: 12),
        StatTile(icon: Icons.language, title: 'Langues pratiquées', value: '$practicedLanguages', color: Colors.green),
      ],
    );
  }

  String _motivation(int total) {
    if (total == 0) return 'Commence par une phrase simple dans un contexte utile.';
    if (total < 5) return 'Bon départ. Essaie plusieurs situations différentes.';
    if (total < 20) return 'Tu progresses bien. Ajoute les phrases utiles en favoris.';
    return 'Objectif atteint. Tu peux viser 50 phrases maintenant.';
  }
}
