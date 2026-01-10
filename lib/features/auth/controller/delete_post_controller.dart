import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/services/post_service.dart';

class DeletePostController extends StateNotifier<AsyncValue<void>> {
  final PostService service;
  DeletePostController( this.service) : super(const AsyncData(null));
  Future<void> deletePost(String postId) async {
    state = AsyncLoading();
    try {
      await service.deletePostService(postId);
      state = const AsyncData(null);
    } catch(e,st) {
      state = AsyncError(e, st);
    }
  }
}