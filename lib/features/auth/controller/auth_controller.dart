import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';
import 'package:rent_connect/features/auth/repositories/auth_repository.dart';
import 'package:rent_connect/features/auth/services/auth_services.dart';
import 'package:rent_connect/features/auth/services/shared_preference.dart';

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthServices _authService;

  AuthController(this._authService) : super(const AsyncData(null));

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
      final user = await _authService.signUpService(
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

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      final user = await _authService.signInService(email, password);
      await SharedPreferenceHelper.saveUser(user);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
