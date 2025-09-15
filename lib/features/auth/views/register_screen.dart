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
                      Text('TÀI KHOẢN', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) => Validators.validateEmail(value),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Mật khẩu'),
                        validator: (value) => Validators.validatePassword(value),
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                        ),
                        validator: (value) => Validators.validateConfirmPassword(
                          value,
                          _passwordController.text,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('THÔNG TIN', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Họ tên'),
                        validator: (value) => Validators.validateName(value),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Số điện thoại'),
                        validator: (value) => Validators.validatePhone(value),
                      ),
                      TextFormField(
                        controller: _communeController,
                        decoration: const InputDecoration(labelText: 'Xã/Phường'),
                        validator: (value) => Validators.validateCommune(value),
                      ),
                      TextFormField(
                        controller: _districtController,
                        decoration: const InputDecoration(labelText: 'Quận/Huyện'),
                        validator: (value) => Validators.validateDistrict(value),
                      ),
                      TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(labelText: 'Thành phố'),
                        validator: (value) => Validators.validateCity(value),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        'VAI TRÒ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Row(
                        children: [
                        Expanded(
                          child: RadioListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Người thuê' , style: TextStyle(fontSize: 15),),
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
                            title: const Text('Người cho thuê', style: TextStyle(fontSize: 15),),
                            value: 'landlord',
                            groupValue: roleState,
                            onChanged: (value) {
                              ref.read(roleProvider.notifier).state = value!;
                            },
                          ),
                        ),
                      ],),

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
