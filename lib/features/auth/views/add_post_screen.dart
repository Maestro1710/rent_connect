
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/core/providers/image_provider.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/core/widgets/input_widget.dart';
import 'package:rent_connect/features/auth/services/image_service.dart';
import 'package:rent_connect/utils/validators.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _PostState();
}

class _PostState extends ConsumerState<AddPostScreen> {
  final _formkey = GlobalKey<FormState>();
  //text controller
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final areaController = TextEditingController();
  final depositController = TextEditingController();
  final communeController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  List<File> selectedImage = [];
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    areaController.dispose();
    depositController.dispose();
    communeController.dispose();
    districtController.dispose();
    cityController.dispose();
    addressController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postControllerProvider);

    void _addPost() {
      if (selectedImage.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bạn phải chọn ít nhất 1 ảnh')),
        );
        return;
      }
      if (_formkey.currentState!.validate()) {
        ref
            .watch(postControllerProvider.notifier)
            .createPost(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              area: double.tryParse(areaController.text.trim()) ?? 0.0,
              deposit: double.tryParse(depositController.text.trim()) ?? 0.0,
              price: double.tryParse(priceController.text.trim()) ?? 0.0,
              address: addressController.text.trim(),
              commune: communeController.text.trim(),
              district: districtController.text.trim(),
              city: cityController.text.trim(),
              image: selectedImage,
            );
      }
    }

    ref.listen(postControllerProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng bài thất bại: ${next.error.toString()}'),
          ),
        );
        ref.read(postControllerProvider.notifier).reset();
      }
      if(next.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng bài thành công'),
          ),
        );
        ref.read(postControllerProvider.notifier).reset();
        context.go(AppRouter.home);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng tin'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('MÔ TẢ'),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () async {
                            final result = await ref
                                .watch(imagePickerServiceProvider)
                                .pickImage();
                            setState(() {
                              selectedImage = result;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt_outlined),
                                Text('CHỌN ẢNH'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InputWidget(
                          controller: titleController,
                          label: 'Tiêu đề',
                          validator: (value) => Validators.validatePost(
                            value,
                            'Tiêu đề không được bỏ trống',
                          ),
                          icon: Icon(Icons.title_outlined),
                        ),
                        const SizedBox(height: 15),
                        InputWidget(
                          controller: descriptionController,
                          label: 'Mô tả',
                          maxLine: 4,
                          validator: (value) => Validators.validatePost(
                            value,
                            'Mô tả không được bỏ trống',
                          ),
                          icon: Icon(Icons.description_outlined),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('ĐỊA CHỈ'),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InputWidget(
                                controller: communeController,
                                label: 'Xã/Phường',
                                validator: (value) => Validators.validatePost(
                                  value,
                                  'Xã/Phường không được bỏ trống',
                                ),
                                icon: Icon(Icons.location_on_outlined),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: InputWidget(
                                controller: districtController,
                                label: 'Quận/Huyện',
                                validator: (value) => Validators.validatePost(
                                  value,
                                  'Quận/Huyện không được bỏ trống',
                                ),
                                icon: Icon(Icons.location_on_outlined),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        InputWidget(
                          controller: cityController,
                          label: 'Tỉnh/Thành phố',
                          validator: (value) => Validators.validatePost(
                            value,
                            'Tỉnh/Thành phố không được bỏ trống',
                          ),
                          icon: Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(height: 15),
                        InputWidget(
                          controller: addressController,
                          label: 'Địa chỉ chi tiết',
                          validator: (value) => Validators.validatePost(
                            value,
                            'địa chỉ chi tiết không được bỏ trống',
                          ),
                          icon: Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('THÔNG TIN CHI TIẾT'),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InputWidget(
                                controller: areaController,
                                label: 'Diện tích',
                                validator: (value) => Validators.validateNumber(
                                  value,
                                  'Diện tích không được bỏ trống',
                                ),
                                keyBoardType: TextInputType.number,
                                icon: Icon(Icons.area_chart_outlined),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 3,
                              child: InputWidget(
                                controller: priceController,
                                label: 'Giá tiền',
                                validator: (value) => Validators.validateNumber(
                                  value,
                                  'Giá tiền không được bỏ trống',
                                ),
                                keyBoardType: TextInputType.number,
                                icon: Icon(Icons.monetization_on_outlined),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        InputWidget(
                          controller: depositController,
                          label: 'Tiền cọc',
                          validator: (value) => Validators.validateNumber(
                            value,
                            'Tiền cọc không được bỏ trống',
                          ),
                          keyBoardType: TextInputType.number,
                          icon: Icon(Icons.monetization_on_outlined),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: postState.isLoading? null : _addPost,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 15,
                              bottom: 15,
                            ),
                          ),
                          child: postState.isLoading ? CircularProgressIndicator(): const Text('Đăng tin'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
