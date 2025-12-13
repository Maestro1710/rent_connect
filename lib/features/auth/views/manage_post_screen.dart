import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';

class ManagePostScreen extends ConsumerWidget {
  const ManagePostScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(managePostProviderController);
    return Scaffold();
  }

}
