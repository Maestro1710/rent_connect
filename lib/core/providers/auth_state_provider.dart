import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/auth_provider.dart';
import 'package:rent_connect/core/providers/user_provider.dart';

final authStateProvider = Provider<bool>((ref) {
  final user = ref.watch(authControllerProvider);
  return user.value != null;
});
