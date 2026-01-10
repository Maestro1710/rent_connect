import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app_router.dart';
import '../../../core/providers/post_provider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchPostControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 SEARCH BAR (CỐ ĐỊNH)
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập từ khóa tìm kiếm...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      ref
                          .read(searchPostControllerProvider.notifier)
                          .clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  isDense: true,
                ),
                onChanged: (value) {
                  ref
                      .read(searchPostControllerProvider.notifier)
                      .search(value);
                },
              ),
            ),

            const SizedBox(height: 8),

            // 📜 KẾT QUẢ (CUỘN ĐƯỢC)
            Expanded(
              child: searchState.when(
                data: (posts) {
                  if (posts.isEmpty) {
                    return const Center(
                      child: Text(
                        'Không có kết quả',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        margin: EdgeInsets.all(12),
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(AppRouter.detailsPost,
                              queryParameters: {'postId': post.postId},
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 140,
                                height: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    post.image.first,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.title,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      ' ${post.price.toString()}/Tháng',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                          child: Text(
                                            post.address,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_city_outlined, color: Colors.grey,size: 15,),
                                        Expanded(
                                          child: Text(
                                            '${post.commune}, ${post.district}, ${post.city}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (e, _) =>  Center(
                  child: Text('Có lỗi xảy ra khi tìm kiếm: ${e.toString()}'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

