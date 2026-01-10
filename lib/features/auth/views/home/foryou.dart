import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/core/providers/post_provider.dart';

class ForYou extends ConsumerWidget {
  const ForYou({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postListControllerProvider);
    return Scaffold(
      body: postList.when(
        data: (posts) {
          if (posts.isEmpty) const Center(child: Text('chưa có bài đăng'));
          return RefreshIndicator(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return GestureDetector(
                  onTap: () {
                    print("ID: ${post.postId}");
                    context.pushNamed(
                      AppRouter.detailsPost,
                      queryParameters: {'postId': post.postId},
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            post.image.first,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${post.price.toStringAsFixed(0) ?? 0} VNĐ/tháng',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            onRefresh: () async {
              await ref.read(postListControllerProvider.notifier).refresh();
            },
          );
        },
        error: (error, _) => Center(child: Text('Lỗi: $error')),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}
