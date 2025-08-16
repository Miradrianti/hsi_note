import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class LoginHandler {
  static const String _userKey = 'currentUser';

  // static bool _dummyUserCreated = false;

  Future<bool> login(String email, String password) async {
    // Simulate API call
    if (email == 'admin' && password == 'admin') {
      final user = User(id: 1, password: '12345678', email: 'test@example.com');
      await _saveUser(user);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }
}


