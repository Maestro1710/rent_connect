import 'dart:io';

import 'package:rent_connect/features/auth/model/post_details_model.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';
import 'package:rent_connect/features/auth/repositories/post_repository.dart';

class PostService {
  final PostRepository repository;

  PostService(this.repository);

  Future<void> uploadPostService({
    required String userId,
    required String title,
    required String description,
    required double area,
    required double deposit,
    required double price,
    required String address,
    required String commune,
    required String district,
    required String city,
    required List<File> image,
  }) async {
    List<String> imgUrls = [];
    for (final img in image) {
      final url = await repository.uploadImage(img);
      imgUrls.add(url);
    }

    await repository.createPost(
      userId: userId,
      title: title,
      description: description,
      area: area,
      deposit: deposit,
      price: price,
      address: address,
      commune: commune,
      district: district,
      city: city,
      image: imgUrls,
    );
  }

  Future<void> updatePostService({
    required String postId,
    required String title,
    required String description,
    required double area,
    required double deposit,
    required double price,
    required String address,
    required String commune,
    required String district,
    required String city,
    required List<File> newImages,
    required List<String> oldImages,
    required List<String> removedImages,
  }) async {
    // Xóa ảnh trên storage
    for (final url in removedImages) {
      await repository.deleteImageByUrl(url);
    }

    // Upload ảnh mới song song
    final uploadedUrls = await Future.wait(
      newImages.map((img) => repository.uploadImage(img)),
    );

    // Loại bỏ các ảnh đã xóa khỏi oldImages
    final filteredOldImages = oldImages
        .where((url) => !removedImages.contains(url))
        .toList();

    final finalImages = [...filteredOldImages, ...uploadedUrls];
    print('final: ${finalImages}');
    await repository.updatePost(
      postId: postId,
      title: title,
      description: description,
      area: area,
      deposit: deposit,
      price: price,
      address: address,
      commune: commune,
      district: district,
      city: city,
      image: finalImages,
    );
  }

  Future<List<PostModel>> getAllPostService() async {
    final posts = await repository.getAllPost();
    return posts;
  }

  Future<PostDetailsModel> getDetailsPostService(String postId) async {
    final detailsPost = await repository.getDetailsPost(postId);
    return detailsPost;
  }

  Future<List<PostModel>> getUserPostService(String userId) async {
    final userPost = await repository.getUserPost(userId);
    return userPost;
  }

  Future<PostModel> getPostByIdService(String postId) async {
    final post = await repository.getPostById(postId);
    return post;
  }

  Future<List<PostModel>> seachPostService (String keyword) async {
    if(keyword.trim().isEmpty) return[];
    final posts = await repository.searchPost(keyword.trim());
    return posts;
  }

  Future<void> deletePostService (String postId) async {
    await repository.deletePost(postId);
  }
}
