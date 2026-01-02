import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostImageController extends StateNotifier<List<dynamic>> {
  PostImageController() : super([]);

  void setOldImage (List<String> urls) {
    state = [...urls];
  }
  void addNewImages(List<File> images) {
    state = [...state,...images];
  }

  void removeAt(int index) {
    final list = [...state];
    list.removeAt(index);
    state = list;
  }
  void clear() => state = [];

  List<File> get newImages => state.whereType<File>().toList();
  List<String> get oldImage => state.whereType<String>().toList();
}