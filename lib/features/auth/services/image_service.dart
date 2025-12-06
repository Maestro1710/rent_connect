import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<List<File>> pickImage () async {
    final picker =  ImagePicker();
    final file = await picker.pickMultiImage(imageQuality: 85);
    return file.map((e)=> File(e.path)).toList();
  }
}