import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';
import 'package:rent_connect/features/auth/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final roleProvider = StateProvider<String>((ref) {
  return 'tenant';
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserModel?>>((ref) {
      return AuthController(ref.read(authRepositoryProvider));
    });

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AsyncData(null));

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String commune,
    required String district,
    required String city,
    required String role,
  }) async {
    state = const AsyncLoading();
    try {
      final user = await _repository.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        commune: commune,
        district: district,
        city: city,
        role: role,
      );
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
