import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/controller/home_controller.dart';
import 'package:rent_connect/features/auth/model/user_model.dart';

import '../../features/auth/services/shared_preference.dart';

final homeProvier = AsyncNotifierProvider<HomeController, UserModel?> (() {
  return HomeController();
});


