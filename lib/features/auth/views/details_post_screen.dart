import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/constants.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/controller/post_details_controller.dart';
import 'package:rent_connect/utils/format_currency.dart';

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
  Widget build(BuildContext context) {
    final state = ref.watch(postDetailsControllerProvider(widget.postId));
    ref.listen(postControllerProvider, (previous, next) {
      if (previous?.success == false && next.success == true) {
        //refresh state
        ref.invalidate(postDetailsControllerProvider(widget.postId));
        Navigator.pop(context);
      }

      if (next.error != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amberAccent,),
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
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          Expanded(
                            child: Text(
                              post.address,
                              style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                          Text(
                            "${post.commune}, ${post.district}, ${post.city}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
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
                      const SizedBox(height: 10),
                      Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        'Thông tin nhà trọ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListTileTheme(
                        dense: true,
                        minVerticalPadding: 0,
                        contentPadding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.aspect_ratio_outlined,
                                size: 25,
                                color: Colors.black,

                              ),
                              title: Text(
                                'Diện tích:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,

                                ),
                              ),
                              trailing: Text(
                                '${post.area.toString()}/m²',
                                style: TextStyle(
                                  fontSize: 15,

                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.payments_outlined,
                                size: 25,
                                color: Colors.black,

                              ),
                              title: Text(
                                'Giá thuê:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,

                                ),
                              ),
                              trailing: Text(
                                '${FormatCurrency(post.price)}/tháng',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.lock_outline,
                                size: 25,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Đặt cọc',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,

                                ),
                              ),
                              trailing: Text(
                                FormatCurrency(post.deposit),
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        'Mô tả chhi tiết',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        post.description,
                        style: TextStyle(fontSize: 15),
                        maxLines: 5,
                      ),
                      ListTile(
                        leading: Text(
                          'SĐT liên hệ: ${post.phoneNumber}',
                          style: TextStyle(fontSize: 15),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 10),
                      Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 10),
                      //comment chua lam :>
                      Center(
                        child: SizedBox(
                          height: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                              Text(
                                'Bình luận',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 10),
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
