import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';

class PostUpdateController extends FamilyAsyncNotifier<PostModel, String> {
  @override
  FutureOr<PostModel> build(String postId) {
    final service = ref.read(postServiceProvider);
    return service.getPostByIdService(postId);
  }

}