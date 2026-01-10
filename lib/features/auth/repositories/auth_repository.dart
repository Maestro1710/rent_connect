import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user_model.dart';

class AuthRepository {
  final SupabaseClient supabase;
  AuthRepository(this.supabase);
  //Create new user
  Future<UserModel> createUser(UserModel user) async {
    final response = await supabase
        .from('tbl_user')
        .insert(user.toJson())
        .select()
        .single();
    return UserModel.fromJson(response);
  }

  //Get user by id
  Future<UserModel?> getUser(String id) async {
    final response = await supabase
        .from('tbl_user')
        .select()
        .eq('user_id', id)
        .maybeSingle();
    //return null if user not found
    return response != null ? UserModel.fromJson(response) : null;
  }

  //Sign up
  Future<AuthResponse> signUp(String email, String passWord) async {
    return await supabase.auth.signUp(email: email, password: passWord);
  }

  //Sign in
  Future<AuthResponse> signIn(String email, String passWord) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: passWord,
    );
  }

  //logout
  Future<void> logOut() async {
    await supabase.auth.signOut();
  }

  // //Dang ky
  // Future<UserModel> signUp({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required String phone,
  //   required String commune,
  //   required String district,
  //   required String city,
  //   required String role,
  // }) async {
  //   try {
  //     final response = await supabase.auth.signUp(
  //       email: email,
  //       password: password,
  //     );
  //     final user = response.user;
  //     if (user == null) {
  //       throw Exception("Không tạo được tài khoản");
  //     }
  //
  //     final insertUser = await supabase
  //         .from('tbl_user')
  //         .insert({
  //           'user_id': user.id,
  //           'user_name': name,
  //           'phone_number': phone,
  //           'commune': commune,
  //           'district': district,
  //           'city': city,
  //           'role': role,
  //         })
  //         .select()
  //         .single();
  //
  //     return UserModel.fromJson(insertUser);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // // Dang nhap
  // Future<UserModel> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await supabase.auth.signInWithPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final user = response.user;
  //     if (user == null) {
  //       throw Exception("Sai email hoac mat khau");
  //     }
  //
  //     final userData = await supabase
  //         .from('tbl_user')
  //         .select()
  //         .eq('user_id', user.id)
  //         .single();
  //     return UserModel.fromJson(userData);
  //   } on AuthException catch (e) {
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
