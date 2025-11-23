import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/auth_provider.dart';
import 'package:rent_connect/core/widgets/logo_widget.dart';
import 'package:rent_connect/features/auth/views/home/home_screen.dart';
import 'package:rent_connect/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }

}


class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passWordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passWordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //theo doi state
    final authState = ref.watch(authControllerProvider);
    ref.watch(roleProvider);
    // dang nhap
    void signIn() {
      if (_formkey.currentState!.validate()) {
        ref
            .read(authControllerProvider.notifier)
            .signIn(
              email: _emailController.text.trim(),
              password: _passWordController.text.trim(),
            );
      }
    }

    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký thất bại: ${next.error}")),
        );
      } else if (next is AsyncData && next.value != null) {
        final user = next.value!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Đăng nhập thành công, chào mứng ${next.value!.name}",
            ),
          ),
        );
        Future.microtask(() {
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          }
        });
      }
    });
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng nhập")),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(alignment: Alignment.center, child: LogoWidget()),
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Đăng Nhập",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.deepPurple,
                      ),
                    ),
                    validator: (value) => Validators.validateEmail(value),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passWordController,
                    decoration: InputDecoration(
                      labelText: "Mật khẩu",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: Colors.deepPurple,
                      ),
                    ),
                    validator: (value) => Validators.validatePassword(value),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: authState is AsyncLoading ? null : signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: authState is AsyncLoading
                        ? const CircularProgressIndicator()
                        : const Text('Đăng nhập'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
