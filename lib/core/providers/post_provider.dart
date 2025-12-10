import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/supabase_provider.dart';
import 'package:rent_connect/features/auth/controller/post_controller.dart';
import 'package:rent_connect/features/auth/controller/post_details_controller.dart';
import 'package:rent_connect/features/auth/controller/post_list__controller.dart';
import 'package:rent_connect/features/auth/model/post_details_model.dart';
import 'package:rent_connect/features/auth/repositories/post_repository.dart';
import 'package:rent_connect/features/auth/services/post_service.dart';

import '../../features/auth/model/post_model.dart';
//post  repository provider
final postRepositoryProvider = Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return PostRepository(supabase);
});
//post service provider
final postServiceProvider =  Provider((ref){
  final repo = ref.watch(postRepositoryProvider);
  return PostService(repo);
});
//post controller provider
final postControllerProvider = StateNotifierProvider<PostController,PostState>((ref) {
  final service = ref.watch(postServiceProvider);
  return PostController(service);
});
final postListProvider =
AsyncNotifierProvider<PostListController, List<PostModel>>(
  PostListController.new,
);

final postDetailsControllerProvider = AsyncNotifierProvider<PostDetailsController, PostDetailsModel> (
    () => PostDetailsController()
);