import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/model/post_details_model.dart';
import 'package:rent_connect/features/auth/model/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostRepository {
  final SupabaseClient supabase;

  PostRepository(this.supabase);

  Future<String> uploadImage(File file) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      //tai file len storage
      final res = await supabase.storage
          .from('post_img')
          .upload(fileName, file);
      //lay url
      final url = supabase.storage.from('post_img').getPublicUrl(fileName);
      return url;
    } catch (e) {
      throw Exception('upload anh that bai: ${e.toString()}');
    }
  }

  Future<void> deleteImage(String url) async {
    final path = Uri.parse(url).pathSegments.last;
    await supabase.storage.from('post_images').remove([path]);
  }

  Future<void> createPost({
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
    required List<String> image,
  }) async {
    try {
      await supabase.from('tbl_post').insert({
        'user_id': userId,
        'title': title,
        'description': description,
        'area': area,
        'deposit': deposit,
        'price': price,
        'address': address,
        'commune': commune,
        'district': district,
        'city': city,
        'image': image,
      });
    } catch (e) {
      throw Exception('upload post that bai: ${e.toString()}');
    }
  }

  Future<List<PostModel>> getAllPost() async {
    try {
      final response = await supabase
          .from('tbl_post')
          .select()
          .order('created_at', ascending: false);
      final List<PostModel> posts = response
          .map<PostModel>((json) => PostModel.fromJson(json))
          .toList();
      return posts;
    } catch (e) {
      throw Exception('lay toan bo bai dang that bai: ${e.toString()}');
    }
  }

  Future<PostModel> getPostById(String postId) async {
    try {
      final response = await supabase
          .from('tbl_post')
          .select()
          .eq('id', int.parse(postId))
          .single();
      return PostModel.fromJson(response);
    } catch (e) {
      throw Exception('Lay post theo id that bai ${e.toString()}');
    }
  }

  //lay chi tiet bai dang voi ten va avatar user
  Future<PostDetailsModel> getDetailsPost(String postId) async {
    try {
      //print("ID: ${postId}");
      final id = int.tryParse(postId.trim());
      if (id == null) {
        throw Exception('postId không hợp lệ: $postId');
      }
      final response = await supabase
          .from('tbl_post')
          .select('''
          *,
          user:user_id(
            user_name, 
            avatar,
            phone_number
          )
          ''')
          .eq('id', id)
          .single();
      //print(PostDetailsModel.fromJson(response).userName);
      return PostDetailsModel.fromJson(response);
    } catch (e) {
      throw Exception('lay chi tiet bai dang that bai${e.toString()}');
    }
  }

  //lay post theo id nguoi dang
  Future<List<PostModel>> getUserPost(String userId) async {
    try {
      //print("ID: ${postId}" );

      final response = await supabase
          .from('tbl_post')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      List<PostModel> posts = (response as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
      return posts;
    } catch (e) {
      throw Exception(
        'lay danh sach bai dang quan ly tin that bai${e.toString()}',
      );
    }
  }

  //update post
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
    required List<String> image,
  }) async {
    try {
      await supabase
          .from('tbl_post')
          .update({
            'title': title,
            'description': description,
            'area': area,
            'deposit': deposit,
            'price': price,
            'address': address,
            'commune': commune,
            'district': district,
            'city': city,
            'image': image,
          })
          .eq('id', int.parse(postId));
      ;
    } catch (e) {
      throw Exception('update that bai: ${e.toString()} ');
    }
  }

  //xoa anh tren spabase
  Future<void> deleteImageByUrl(String imageUrl) async {
    try {
      final uri = Uri.parse(imageUrl);

      // Tách path sau "/object/public/"
      final segments = uri.path.split('/object/public/');
      if (segments.length < 2) {
        throw Exception('Invalid Supabase image url');
      }

      final fullPath = segments[1];
      // vd: posts/abc123.jpg

      final bucket = fullPath.split('/').first;
      final filePath = fullPath.substring(bucket.length + 1);

      await supabase.storage.from('tbl_post').remove([filePath]);
    } catch (e) {
      throw Exception('Delete image failed: $e');
    }
  }

  //search post
  Future<List<PostModel>> searchPost(String keyword) async {
    try {
      final response = await supabase
          .from('tbl_post')
          .select()
          .or(
            'title.ilike.%$keyword%,'
            'address.ilike.%$keyword%,'
            'city.ilike.%$keyword%,'
            'commune.ilike.%$keyword%,'
            'district.ilike.%$keyword%',
          )
          .order('created_at', ascending: false);
      return response.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('searchPost that bai : ${e.toString()}');
    }
  }

  //delete post
  Future<void> deletePost(String postId) async {
    try {
      await supabase.from('tbl_post').delete().eq('id', int.parse(postId));
    } catch (e) {
      throw Exception('deletePost that bai: ${e.toString()}');
    }
  }
}
