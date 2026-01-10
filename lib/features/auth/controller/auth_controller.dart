import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';
import 'package:rent_connect/features/auth/repositories/auth_repository.dart';
import 'package:rent_connect/features/auth/services/auth_services.dart';
import 'package:rent_connect/features/auth/services/shared_preference.dart';

import '../../../core/providers/bottom_nav_provider.dart';
import '../../../core/providers/home_provider.dart';
import '../../../core/providers/post_provider.dart';
import '../../../core/providers/user_provider.dart';

class AuthController extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthServices _authService;
  final Ref ref;

  AuthController(this._authService, this.ref) : super(const AsyncData(null));

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
      ref.read(userProvider.notifier).saveUser(user);
      await SharedPreferenceHelper.saveUser(user);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
  Future<void> logOut() async {
    state = AsyncLoading();
    try {
      await _authService.logOutService();
      ref.read(userProvider.notifier).removeUser();
      await SharedPreferenceHelper.removeUser();
      state = AsyncData(null);
      ref.read(bottomNavProvider.notifier).changeTab(0);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
  Future<void> restoreSession() async {
    state = const AsyncLoading();

    final user = await SharedPreferenceHelper.getUser();
    if (user != null) {
      ref.read(userProvider.notifier).loadUser();
    }
    state = AsyncData(user);
  }

}
