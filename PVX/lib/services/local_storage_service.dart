import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/translation_item.dart';

class LocalStorageService {
  static const String _historyKey = 'poketvox_history';

  Future<List<TranslationItem>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawItems = prefs.getStringList(_historyKey) ?? [];
    return rawItems
        .map((item) => TranslationItem.fromJson(jsonDecode(item)))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveHistory(List<TranslationItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _historyKey,
      items.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
