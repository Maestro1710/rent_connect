import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user_model.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String commune,
    required String district,
    required String city,
    required String role,
  }) async {
    try{
      final response = await supabase.auth.signUp(email: email ,password: password);
      final user = response.user;
      if(user == null) {
        throw Exception("Không tạo được tài khoản");
      }

      final insertUser = await supabase.from('tbl_user').insert({
        'user_id':user.id,
        'user_name': name,
        'phone_number': phone,
        'commune': commune,
        'district': district,
        'city': city,
        'role': role,
      }).select().single();
      
      return UserModel.fromJson(insertUser);
    } catch(e) {
      rethrow;
    }

  }
}
