import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/post_provider.dart';

class ManagePostScreen extends ConsumerWidget {
  const ManagePostScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(managePostProviderController);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(backgroundColor: Colors.amberAccent,
          title: Text('Quản lý tin đăng'),
          
        
        ),
      ),
      body: postList.when(
        data: (postList) {
          if (postList.isEmpty) {
            return const Center(child: Text('Chưa có bài đăng'));
          }
          return RefreshIndicator(
            onRefresh: () {
              return ref
                  .watch(managePostProviderController.notifier)
                  .loadUserPost();
            },
            child: ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                final post = postList[index];
                return Card(
                  margin: EdgeInsets.all(12),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      //trang xem chi tiet post(co nut sua va xoa bai dang)
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
            ),
          );
        },
        error: (err, _) => Center(child: Text(err.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
