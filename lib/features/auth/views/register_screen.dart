import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/controller/auth_controller.dart';
import 'package:rent_connect/utils/validators.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _communeController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();

  String _role = 'tenant';

  @override
  Widget build(BuildContext context) {
    //Theo doi state
    final authState = ref.watch(authControllerProvider);
    final roleState = ref.watch(roleProvider);
    //dang ky
    void _register() {
      if (_formkey.currentState!.validate()) {
        final role = ref.read(roleProvider);

        ref
            .read(authControllerProvider.notifier)
            .signUp(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              name: _nameController.text.trim(),
              phone: _phoneController.text.trim(),
              commune: _communeController.text.trim(),
              district: _districtController.text.trim(),
              city: _cityController.text.trim(),
              role: role,
            );
      }
    }

    //lang nghe state de hien thi thong bao
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thất bại: ${next.error}')),
        );
      } else if (next is AsyncData && next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chào mừng ${next.value!.name}!')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'TÀI KHOẢN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) => Validators.validateEmail(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.deepPurple,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) =>
                            Validators.validatePassword(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration:  InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                              value,
                              _passwordController.text,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'THÔNG TIN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration:  InputDecoration(labelText: 'Họ tên',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.deepPurple,
                          ),),
                        validator: (value) => Validators.validateName(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) => Validators.validatePhone(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _communeController,
                        decoration: InputDecoration(
                          labelText: 'Xã/Phường',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) => Validators.validateCommune(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _districtController,
                        decoration: InputDecoration(
                          labelText: 'Quận/Huyện',
                          border: OutlineInputBorder(
                            borderRadius:     BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) =>
                            Validators.validateDistrict(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'Thành phố',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (value) => Validators.validateCity(value),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        'VAI TRÒ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                'Người thuê',
                                style: TextStyle(fontSize: 15),
                              ),
                              value: 'tenant',
                              groupValue: roleState,
                              onChanged: (value) {
                                ref.read(roleProvider.notifier).state = value!;
                              },
                            ),
                          ),

                          Expanded(
                            child: RadioListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: const Text(
                                'Người cho thuê',
                                style: TextStyle(fontSize: 15),
                              ),
                              value: 'landlord',
                              groupValue: roleState,
                              onChanged: (value) {
                                ref.read(roleProvider.notifier).state = value!;
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: authState is AsyncLoading ? null : _register,
                        child: authState is AsyncLoading
                            ? const CircularProgressIndicator()
                            : const Text('Đăng ký'),
                      ),
                    ],
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
