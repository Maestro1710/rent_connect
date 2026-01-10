import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';
import 'package:rent_connect/features/auth/services/post_service.dart';

class SearchPostController extends StateNotifier<AsyncValue<List<PostModel>>> {
  final PostService postService;
  SearchPostController(this.postService) : super(const AsyncData([]));
  Future<void> search(String keyword) async {
    state = AsyncValue.loading();
    try {
      final data = await postService.seachPostService(keyword);
      state = AsyncValue.data(data);
    }catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clear () {
    state = const AsyncValue.data([]);
  }
}