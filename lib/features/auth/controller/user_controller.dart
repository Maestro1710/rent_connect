import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/services/shared_preference.dart';

import '../model/user_model.dart';

class UserController extends StateNotifier<UserModel?> {
  UserController() : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    state = await SharedPreferenceHelper.getUser();
  }

  Future<void> _saveUser(UserModel user) async {
    await SharedPreferenceHelper.saveUser(user);
    state = user;
  }

  Future<void> _removeUser() async {
    await SharedPreferenceHelper.removeUser();
    state = null;
  }
}