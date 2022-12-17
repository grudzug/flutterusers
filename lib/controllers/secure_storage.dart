import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  UserSecureStorage({required this.user});

  final String user;
  static const _storage = FlutterSecureStorage();
  static const _keyUser = 'user';

  static Future<void> saveUser(String user) async {
    await _storage.write(key: _keyUser, value: user);
  }

  static Future<String> getUser() async {
    return await _storage.read(key: _keyUser) ?? '';
  }
}
