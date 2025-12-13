import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';

class ManagePostController extends AsyncNotifier<List<PostModel>> {
  @override
  FutureOr<List<PostModel>> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> loadUserPost (String userId) async {
    final service = ref.read(postServiceProvider);
    state = const AsyncLoading();
    try {
      final data = await service.getUserPostService(userId);
      state = AsyncData(data);
    }catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

}