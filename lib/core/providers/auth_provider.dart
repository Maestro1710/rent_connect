import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/services/auth_services.dart';

import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/model/user_model.dart';
import '../../features/auth/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authServiceProvider = Provider<AuthServices>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthServices(repo);
});
final roleProvider = StateProvider<String>((ref) {
  return 'tenant';
});

final authControllerProvider =
StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
  return AuthController(ref.read(authServiceProvider));
});