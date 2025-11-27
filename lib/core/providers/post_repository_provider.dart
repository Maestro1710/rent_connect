import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/supabase_provider.dart';

final postRepositoryProvider = Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return postRepositoryProvider(supabase);
});