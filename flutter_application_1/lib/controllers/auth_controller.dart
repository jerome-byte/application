import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthController extends ChangeNotifier {
  UserModel? _user;
  final List<UserModel> _users = [
    UserModel(id: 'u1', name: 'Demo User', email: 'demo@example.com'),
  ];

  static const _kUserKey = 'auth_user_raw';

  AuthController() {
    _loadFromPrefs();
  }

  UserModel? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kUserKey);
    if (raw != null) {
      try {
        _user = UserModel.fromRawJson(raw);
        // Keep user in list (for mock lookup)
        if (!_users.any((u) => u.email == _user!.email)) {
          _users.add(_user!);
        }
        notifyListeners();
      } catch (_) {}
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (_user != null) {
      await prefs.setString(_kUserKey, _user!.toRawJson());
    } else {
      await prefs.remove(_kUserKey);
    }
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final found = _users.where((u) => u.email == email).toList();
    if (found.isNotEmpty) {
      _user = found.first;
      await _saveToPrefs();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final exists = _users.any((u) => u.email == email);
    if (exists) return false;
    final newUser = UserModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, email: email);
    _users.add(newUser);
    _user = newUser;
    await _saveToPrefs();
    notifyListeners();
    return true;
  }

  void logout() async {
    _user = null;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> updateProfile({String? name, String? photoUrl}) async {
    if (_user == null) return;
    if (name != null) _user!.name = name;
    if (photoUrl != null) _user!.photoUrl = photoUrl;
    // persist
    await _saveToPrefs();
    notifyListeners();
  }
}
