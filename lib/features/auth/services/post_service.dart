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
  }) async {
    List<String> imgUrls = [];
    for (final img in newImages) {
      final url = await repository.uploadImage(img);
      imgUrls.add(url);
    }
    imgUrls.addAll(oldImages);
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
      image: imgUrls,
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
}
