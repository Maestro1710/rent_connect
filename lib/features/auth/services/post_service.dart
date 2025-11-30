import 'dart:io';

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
}
