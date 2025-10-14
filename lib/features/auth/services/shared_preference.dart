import 'dart:convert';

import 'package:rent_connect/features/auth/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const _userKey = 'user';
  //Luu user vao sharedPreferences
  static Future<void> saveUser (UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(user.toJson()) ;
    await prefs.setString(_userKey, jsonStr);
  }
  //lay user o sharedPreferences
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_userKey);
    if(jsonStr != null) {
      final data = jsonDecode(jsonStr);
      return UserModel.fromJson(data);
    }
    return null;
  }
  //xoa user khoi sharedPreferences
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}




























