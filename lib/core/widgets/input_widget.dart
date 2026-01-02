import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final Icon? icon;
  final int maxLine;

  const InputWidget({
    required this.controller,
    required this.label,
    this.validator,
    this.keyBoardType,
    this.icon,
    this.maxLine =1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLine,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: label,
        alignLabelWithHint: true,
        prefixIcon: icon,
      ),
    );
  }
}
