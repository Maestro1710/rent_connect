import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/constants.dart';
import 'package:rent_connect/core/providers/auth_provider.dart';
import 'package:rent_connect/core/providers/auth_state_provider.dart';
import 'package:rent_connect/core/providers/home_provider.dart';
import 'package:rent_connect/core/providers/post_provider.dart';
import 'package:rent_connect/core/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Container(
      color: Colors.grey[200],
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 70, 10, 20),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    user?.avatar ?? defaultAvatarUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                user?.name??'',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      'Đăng Xuất',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onTap: () async  {
                      await ref.read(authControllerProvider.notifier).logOut();
                      ref.invalidate(userProvider);
                      ref.invalidate(managePostProviderController);
                      ref.invalidate(homeProvier);
                      ref.invalidate(authControllerProvider);
                    },
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
