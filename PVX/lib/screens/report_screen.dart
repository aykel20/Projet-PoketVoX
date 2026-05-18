import 'package:flutter/material.dart';
import '../models/translation_item.dart';
import '../widgets/stat_tile.dart';

class ReportScreen extends StatelessWidget {
  final List<TranslationItem> history;
  const ReportScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final weeklyItems = _weeklyItems;
    final favoriteCount = history.where((item) => item.isFavorite).length;
    final uniqueThemes = weeklyItems.map((item) => item.theme).toSet().length;
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text('Bilan hebdomadaire', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('Tes statistiques sur les 7 derniers jours.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 18),
        StatTile(icon: Icons.translate, title: 'Traductions cette semaine', value: '${weeklyItems.length}', color: const Color(0xFF6C5CE7)),
        const SizedBox(height: 12),
        StatTile(icon: Icons.category, title: 'Thème le plus utilisé', value: _mostUsedTheme(weeklyItems), color: const Color(0xFFE84393)),
        const SizedBox(height: 12),
        StatTile(icon: Icons.star, title: 'Favoris enregistrés', value: '$favoriteCount', color: const Color(0xFFFFB000)),
        const SizedBox(height: 12),
        StatTile(icon: Icons.explore, title: 'Contextes pratiqués', value: '$uniqueThemes', color: const Color(0xFF00B894)),
      ],
    );
  }

  List<TranslationItem> get _weeklyItems {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return history.where((item) => item.createdAt.isAfter(sevenDaysAgo)).toList();
  }

  String _mostUsedTheme(List<TranslationItem> items) {
    if (items.isEmpty) return 'Aucun thème';
    final counts = <String, int>{};
    for (final item in items) {
      counts[item.theme] = (counts[item.theme] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }
}
