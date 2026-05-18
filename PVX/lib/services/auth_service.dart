
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';

class AuthService {
  static const _usersKey = 'pvx_users';
  static const _currentUserKey = 'pvx_current_user';

  Future<List<AppUser>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_usersKey) ?? [];
    return raw.map((e) => AppUser.fromJson(jsonDecode(e))).toList();
  }

  Future<AppUser?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_currentUserKey);
    if (id == null) return null;
    final users = await getUsers();
    for (final u in users) {
      if (u.id == id) return u;
    }
    return null;
  }

  Future<AppUser> register(String name, String pin) async {
    final cleanName = name.trim();
    final cleanPin = pin.trim();
    if (cleanName.length < 2) throw Exception('Nom trop court');
    if (cleanPin.length < 4) throw Exception('Code PIN trop court');
    final users = await getUsers();
    if (users.any((u) => u.name.toLowerCase() == cleanName.toLowerCase())) {
      throw Exception('Ce compte existe déjà');
    }
    final user = AppUser(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: cleanName,
      pin: cleanPin,
      createdAt: DateTime.now(),
    );
    users.add(user);
    await _saveUsers(users);
    await setCurrentUser(user.id);
    return user;
  }

  Future<AppUser> login(String name, String pin) async {
    final users = await getUsers();
    for (final user in users) {
      if (user.name.toLowerCase() == name.trim().toLowerCase() && user.pin == pin.trim()) {
        await setCurrentUser(user.id);
        return user;
      }
    }
    throw Exception('Compte ou code PIN incorrect');
  }

  Future<void> setCurrentUser(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, id);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<void> _saveUsers(List<AppUser> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_usersKey, users.map((u) => jsonEncode(u.toJson())).toList());
  }
}
