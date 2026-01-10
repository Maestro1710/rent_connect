import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostImageController extends StateNotifier<List<dynamic>> {
  PostImageController() : super([]);
  final List<String> _removedOldImages = [];

  void setOldImage (List<String> urls) {
    state = [...urls];
  }
  void addNewImages(List<File> images) {
    state = [...state,...images];
  }

  void removeAt(int index) {
    final removed = state[index];
    if(removed is String) {
      _removedOldImages.add(removed);
    }
    final list = [...state]..removeAt(index);
    state = list;
  }
  void clear() {
    state = [];
    _removedOldImages.clear();
  }

  List<File> get newImages => state.whereType<File>().toList();
  List<String> get oldImage => state.whereType<String>().toList();
  List<String> get removedOldImages => _removedOldImages;
}