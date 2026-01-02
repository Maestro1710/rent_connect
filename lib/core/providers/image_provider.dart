import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/controller/post_image_controller.dart';
import 'package:rent_connect/features/auth/services/image_service.dart';

final imagePickerServiceProvider = Provider((ref) => ImagePickerService());
final postImageControllerProvider =
    StateNotifierProvider<PostImageController, List<dynamic>>(
      (ref) => PostImageController(),
    );
