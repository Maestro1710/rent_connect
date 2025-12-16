import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';
import 'package:rent_connect/features/auth/services/shared_preference.dart';

class ManagePostController extends AsyncNotifier<List<PostModel>> {
  @override
  Future<List<PostModel>> build() async {
    final service = ref.read(postServiceProvider);
    final user = await SharedPreferenceHelper.getUser();
    if (user == null) {
      throw Exception('User chua dang nhap');
      }
    return await service.getUserPostService(user.userId);
  }

  Future<void> loadUserPost () async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(()async {
      final service = ref.read(postServiceProvider);
      final user = await SharedPreferenceHelper.getUser();
      if(user == null) {
        throw Exception('User chua dang nhap');
      }
      return await service.getUserPostService(user.userId);
    });
  }

}