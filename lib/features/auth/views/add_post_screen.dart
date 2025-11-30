import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/image_provider.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/features/auth/services/image_service.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostState();
}

class _PostState extends ConsumerState<AddPostScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng tin'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Form(
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
                        InkWell(
                          onTap: () async {
                            final result = await ref.read(imagePickerServiceProvider).pickImage();
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
                                Text('CHỌN ẢNH', ),
                              ],
                            ),
                          ),
                        ),
                        TextFormField()
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

