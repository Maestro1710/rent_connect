import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';

class PostListController extends AsyncNotifier<List<PostModel>> {
  @override
  FutureOr<List<PostModel>> build() async {
    final service = ref.watch(postServiceProvider);
    return await service.getAllPostService();

  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(postServiceProvider);
      final posts = await service.getAllPostService();
      return posts;
    });
  }

}