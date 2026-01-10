import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/core/providers/image_provider.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/core/widgets/input_widget.dart';
import 'package:rent_connect/core/widgets/post_form.dart';
import 'package:rent_connect/features/auth/services/image_service.dart';
import 'package:rent_connect/utils/validators.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _PostState();
}

class _PostState extends ConsumerState<AddPostScreen> {
  //text controller

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(postImageControllerProvider.notifier);
    final postState = ref.watch(postControllerProvider);

    // void addPost() {
    //   if (images.newImages.isEmpty) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Bạn phải chọn ít nhất 1 ảnh')),
    //     );
    //     return;
    //   }
    //   ref
    //       .watch(postControllerProvider.notifier)
    //       .createPost(
    //         title: titleController.text.trim(),
    //         description: descriptionController.text.trim(),
    //         area: double.tryParse(areaController.text.trim()) ?? 0.0,
    //         deposit: double.tryParse(depositController.text.trim()) ?? 0.0,
    //         price: double.tryParse(priceController.text.trim()) ?? 0.0,
    //         address: addressController.text.trim(),
    //         commune: communeController.text.trim(),
    //         district: districtController.text.trim(),
    //         city: cityController.text.trim(),
    //         image: images.newImages,
    //       );
    // }

    ref.listen(postControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng bài thất bại: ${next.error.toString()}'),
          ),
        );
        ref.read(postControllerProvider.notifier).reset();
      }
      if (next.success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Đăng bài thành công')));
        ref.read(postImageControllerProvider.notifier).clear();
        ref.read(postControllerProvider.notifier).reset();
        context.go(AppRouter.home);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng tin'),
        backgroundColor: Colors.amberAccent,
      ),
      body: PostForm(
        onSubmit:
            ({
              required title,
              required description,
              required price,
              required area,
              required deposit,
              required commune,
              required district,
              required city,
              required address,
            }) {
              final imageCtrl = ref.read(postImageControllerProvider.notifier);

              if (imageCtrl.newImages.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bạn phải chọn ít nhất 1 ảnh')),
                );
                return;
              }

                ref
                  .read(postControllerProvider.notifier)
                  .createPost(
                    title: title,
                    description: description,
                    price: price,
                    area: area,
                    deposit: deposit,
                    commune: commune,
                    district: district,
                    city: city,
                    address: address,
                    image: imageCtrl.newImages,
                  );
            },
      ),
    );
  }
}
