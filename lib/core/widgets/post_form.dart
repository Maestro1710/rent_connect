

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/image_provider.dart';

import '../../features/auth/model/post_model.dart';
import '../../utils/validators.dart';
import 'input_widget.dart';

typedef PostSubmitCallback =
    void Function({
      required String title,
      required String description,
      required double price,
      required double area,
      required double deposit,
      required String commune,
      required String district,
      required String city,
      required String address,
    });

class PostForm extends ConsumerStatefulWidget {
  final PostModel? post;
  final PostSubmitCallback onSubmit;

  const PostForm({super.key, this.post, required this.onSubmit});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostFormState();
}

class _PostFormState extends ConsumerState<PostForm> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController areaController;
  late final TextEditingController depositController;
  late final TextEditingController communeController;
  late final TextEditingController districtController;
  late final TextEditingController cityController;
  late final TextEditingController addressController;
  //anh

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    areaController = TextEditingController();
    depositController = TextEditingController();
    communeController = TextEditingController();
    districtController = TextEditingController();
    cityController = TextEditingController();
    addressController = TextEditingController();
    if (widget.post != null) {
      final p = widget.post!;
      titleController.text = p.title;
      descriptionController.text = p.description;
      priceController.text = p.price.toString();
      areaController.text = p.area.toString();
      depositController.text = p.deposit.toString();
      communeController.text = p.commune;
      districtController.text = p.district;
      cityController.text = p.city;
      addressController.text = p.address;
      WidgetsBinding.instance.addPostFrameCallback((_){
        ref.read(postImageControllerProvider.notifier).setOldImage(p.image);
      });
    }
  }

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
    final images = ref.watch(postImageControllerProvider);
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('MÔ TẢ'),
            const SizedBox(height: 15),

            //xu ly anh
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                InkWell(
                  onTap: () async {
                    final result = await ref
                        .watch(imagePickerServiceProvider)
                        .pickImage();
                    if (result.isNotEmpty) {
                      ref
                          .read(postImageControllerProvider.notifier)
                          .addNewImages(result);
                    }
                  },
                  child: images.isEmpty
                      ? Container(
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
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
                ...List.generate(images.length, (index) {
                  final img = images[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: img is String
                            ? Image.network(
                                images[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                images[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {

                              ref
                                  .read(postImageControllerProvider.notifier)
                                  .removeAt(index);

                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 15),
            InputWidget(
              controller: titleController,
              label: 'Tiêu đề',
              validator: (value) =>
                  Validators.validatePost(value, 'Tiêu đề không được bỏ trống'),
              icon: Icon(Icons.title_outlined),
            ),
            const SizedBox(height: 15),
            InputWidget(
              controller: descriptionController,
              label: 'Mô tả',
              maxLine: 4,
              validator: (value) =>
                  Validators.validatePost(value, 'Mô tả không được bỏ trống'),
              icon: Icon(Icons.description_outlined),
            ),
            const SizedBox(height: 15),
            Align(alignment: Alignment.centerLeft, child: Text('ĐỊA CHỈ')),
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
            widget.post == null
                ? Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          widget.onSubmit(
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            price: double.parse(priceController.text),
                            area: double.parse(areaController.text),
                            deposit: double.parse(depositController.text),
                            commune: communeController.text.trim(),
                            district: districtController.text.trim(),
                            city: cityController.text.trim(),
                            address: addressController.text.trim(),
                          );
                        }
                      },

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
                      child: const Text('Đăng tin'),
                    ),
                )
                : Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            widget.onSubmit(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              price: double.parse(priceController.text),
                              area: double.parse(areaController.text),
                              deposit: double.parse(depositController.text),
                              commune: communeController.text.trim(),
                              district: districtController.text.trim(),
                              city: cityController.text.trim(),
                              address: addressController.text.trim(),
                            );
                          }
                        },
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
                        child: Text('Cập nhật'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            widget.onSubmit(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              price: double.parse(priceController.text),
                              area: double.parse(areaController.text),
                              deposit: double.parse(depositController.text),
                              commune: communeController.text.trim(),
                              district: districtController.text.trim(),
                              city: cityController.text.trim(),
                              address: addressController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 15,
                            bottom: 15,
                          ),
                        ),
                        child: Text('Xóa tin'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
