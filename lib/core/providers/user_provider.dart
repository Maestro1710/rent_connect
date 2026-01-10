import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/controller/user_controller.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';

final userProvider = StateNotifierProvider<UserController, UserModel?>((ref) {
  final controller = UserController();
  controller.loadUser();
  return controller;
});