import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/model/post_details_model.dart';

class PostDetailsController extends AsyncNotifier<PostDetailsModel> {
  @override
  FutureOr<PostDetailsModel> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
  Future<void> loadPost (String postId) async {
    final service = ref.read(postServiceProvider);
    state = const AsyncLoading();
    try {
      final data = await service.getDetailsPostService(postId);
      state = AsyncData(data);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }


  }

}