import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/controller/bottom_nav_controller.dart';

final bottomNavProvider = StateNotifierProvider<BottomNavController, int>(
    (ref) {
      return BottomNavController();
    }
);