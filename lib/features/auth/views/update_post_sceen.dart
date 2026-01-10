import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/image_provider.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/core/widgets/post_form.dart';

class UpdatePostScreen extends ConsumerWidget {
  final String postId;

  const UpdatePostScreen({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(postControllerProvider, (previous, next) {
      if (previous?.success == false && next.success == true) {
        ref.read(postImageControllerProvider.notifier).clear();
        ref.invalidate(postUpdateControllerProvider(postId));
        ref.invalidate(postDetailsControllerProvider(postId));
        Navigator.pop(context);
      }
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });
    final post = ref.watch(postUpdateControllerProvider(postId));
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amberAccent),
      body: post.when(
        data: (post) {
          return PostForm(
            post: post,
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

                  final imgCtrl = ref.read(
                    postImageControllerProvider.notifier,
                  );
                  ref
                      .read(postControllerProvider.notifier)
                      .updatePost(
                        postId: post.postId!,
                        title: title,
                        description: description,
                        area: area,
                        deposit: deposit,
                        price: price,
                        address: address,
                        commune: commune,
                        district: district,
                        city: city,
                        newImages: imgCtrl.newImages,
                        oldImages:  imgCtrl.oldImage.where((url) => !imgCtrl.removedOldImages.contains(url)).toList(),
                        removedImages: imgCtrl.removedOldImages,
                      );
                },
          );
        },
        error: (err, _) => Center(child: Text('Lỗi: ${err.toString()}')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
