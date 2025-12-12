import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/constants.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/controller/post_details_controller.dart';

class DetailsPostScreen extends ConsumerStatefulWidget {
  final String postId;
  const DetailsPostScreen({super.key, required this.postId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DetailsPostScreenState();
  }
}

class _DetailsPostScreenState extends ConsumerState<DetailsPostScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(postDetailsControllerProvider.notifier).loadPost(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postDetailsControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: state.when(
        data: (post) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 260,
                  child: PageView.builder(
                    itemCount: post.image.length,
                    itemBuilder: (_, index) => ClipRRect(
                      child: Image.network(
                        post.image[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.black54,
                            size: 20,
                          ),
                          Text(
                            post.address,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city_outlined,
                            size: 20,
                            color: Colors.black54,
                          ),
                          Text(
                            "${post.commune}, ${post.district}, ${post.city}",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              post.userAvatar ?? defaultAvatarUrl,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(post.userName ?? 'Người đăng'),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Divider(height: 1, color: Colors.grey,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        error: (err, _) => Center(child: Text('Lỗi: ${err.toString()}')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
