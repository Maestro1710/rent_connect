import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        'user_id':userId,
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
}
