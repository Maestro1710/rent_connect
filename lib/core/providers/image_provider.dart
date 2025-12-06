import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/services/image_service.dart';

final imagePickerServiceProvider = Provider((ref)=>ImagePickerService());