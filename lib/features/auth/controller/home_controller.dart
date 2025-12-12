//default avatar
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';

import '../../../constants.dart';
import '../services/shared_preference.dart';



class HomeController extends AsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() async {
    final UserModel? user = await SharedPreferenceHelper.getUser();
    // tra ve default avatar neu khong co avatar
    if(user == null) return null;
    return user.copyWith(avatar: user.avatar ?? defaultAvatarUrl);
  }


}










