
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/translation_record.dart';

class StorageService {
  static const _recordsKey = 'pvx_records';

  Future<List<TranslationRecord>> getRecords(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_recordsKey) ?? [];
    final all = raw.map((e) => TranslationRecord.fromJson(jsonDecode(e))).toList();
    return all.where((r) => r.userId == userId).toList()..sort((a,b)=>b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addRecord(TranslationRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_recordsKey) ?? [];
    final all = raw.map((e) => TranslationRecord.fromJson(jsonDecode(e))).toList();
    all.add(record);
    await prefs.setStringList(_recordsKey, all.map((r)=>jsonEncode(r.toJson())).toList());
  }

  Future<void> replaceUserRecords(String userId, List<TranslationRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_recordsKey) ?? [];
    final all = raw.map((e) => TranslationRecord.fromJson(jsonDecode(e))).toList();
    final others = all.where((r) => r.userId != userId).toList();
    final merged = [...others, ...records];
    await prefs.setStringList(_recordsKey, merged.map((r)=>jsonEncode(r.toJson())).toList());
  }
}
