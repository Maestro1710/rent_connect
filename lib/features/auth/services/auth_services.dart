import 'package:rent_connect/features/auth/model/user_model.dart';
import 'package:rent_connect/features/auth/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final AuthRepository _repository;

  AuthServices(this._repository);

  Future<UserModel?> signUpService ({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String commune,
    required String district,
    required String city,
    required String role,
}) async {
    try {
      final response = await _repository.signUp(email, password);
      final user = response.user;
      if(user == null) {
        throw Exception("Không tạo được tài khoản");
      }
        final userModel = UserModel(userId: user.id, name: name, phone: phone, commune: commune, district: district, city: city, role: role);
        return await _repository.createUser(userModel);
    } on AuthException catch (e) {
      //Supabase auth error
      throw Exception("Lỗi supabase auth: ${e.message}");
    } on PostgrestException catch (e) {
      //Database error
      throw Exception("Lỗi cơ sở dữ liệu: ${e.message}");
    } catch (e) {
      throw Exception("Lỗi khác");
    }

  }

  Future<UserModel> signInService (String email, String password) async {
    try {
      final response = await _repository.signIn(email, password);
      final user = response.user;
      //response return null
      if(user == null) {
        throw Exception("Đăng nhập thất bại");
      }
      //if user not in database
      final userData = await _repository.getUser(user.id);
      if(userData == null) {
        throw Exception("Không tìm thấy thông tin tài khoản");
      }
      return userData;
    } on AuthException catch (e) {
      //Supabase auth error
      throw Exception("Lỗi supabase auth: ${e.message}");
    } catch (e) {
      print(e.toString());
      throw Exception(" thất bại");
    }
  }
}