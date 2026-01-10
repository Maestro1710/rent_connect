import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/services/shared_preference.dart';

import '../model/user_model.dart';

class UserController extends StateNotifier<UserModel?> {
  UserController() : super(null) ;


  Future<void> loadUser() async {
    final user = await SharedPreferenceHelper.getUser();
    state = user;
  }

  Future<void> saveUser(UserModel user) async {
    await SharedPreferenceHelper.saveUser(user);
    state = user;
  }

  Future<void> removeUser() async {
    await SharedPreferenceHelper.removeUser();
    state = null;
  }
}