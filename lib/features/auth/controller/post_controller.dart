//tao state rieng cho postcontroller (StateNotifier)
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/services/post_service.dart';
import 'package:rent_connect/features/auth/services/shared_preference.dart';

class PostState {
  final bool isLoading;
  final bool success;
  final String? error;

  PostState({this.isLoading = false, this.success = false, this.error});

  PostState copyWith({bool? isLoading, bool? success, String? error}) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error,
    );
  }
}

class PostController extends StateNotifier<PostState> {
  final PostService service;
  PostController(this.service) : super(PostState());

  void reset() {
    state = PostState();
  }

  Future<void> createPost({
    String? userId,
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
    try {
      state = state.copyWith(isLoading: true);
      final user = await SharedPreferenceHelper.getUser();
      if (user == null) {
        throw Exception('chua dang nhap');
      }
      await service.uploadPostService(
        userId: user.userId,
        title: title,
        description: description,
        area: area,
        deposit: deposit,
        price: price,
        address: address,
        commune: commune,
        district: district,
        city: city,
        image: image,
      );
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updatePost({
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
    try {
      state = state.copyWith(isLoading: true);
      await service.updatePostService(
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
        newImages: newImages,
        oldImages: oldImages, removedImages: removedImages,
      );
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
