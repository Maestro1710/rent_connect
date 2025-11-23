//default avatar
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';

import '../services/shared_preference.dart';

const defaultAvatarUrl = 'https://oryespgaoshjvihfmpyc.supabase.co/storage/v1/object/public/avatar/avatar/avatar-anh-meo-cute.jpg';

class HomeController extends AsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() async {
    final UserModel? user = await SharedPreferenceHelper.getUser();
    // tra ve default avatar neu khong co avatar
    if(user == null) return null;
    return user.copyWith(avatar: user.avatar ?? defaultAvatarUrl);
  }


}










