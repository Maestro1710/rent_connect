import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/core/providers/bottom_nav_provider.dart';
import 'package:rent_connect/core/providers/user_provider.dart';
import 'package:rent_connect/features/auth/views/chat_screen.dart';
import 'package:rent_connect/features/auth/views/home/home_screen.dart';
import 'package:rent_connect/features/auth/views/manage_post/manage_post_screen.dart';
import 'package:rent_connect/features/auth/views/profile_screen.dart';

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    final user = ref.watch(userProvider);
    final screens = [
      HomeScreen(),
      ManagePostScreen(),
      SizedBox(),
      ChatScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      extendBody: true,
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: () {
          if (user != null) {
            context.push(AppRouter.addPost);
          } else {
            context.push(AppRouter.login);
          }
        },
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          height: 72,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(
                  icon: Icons.home,
                  label: "Trang chủ",
                  index: 0,
                  currentIndex: currentIndex,
                  ref: ref,
                  user: user,
                ),

                _navItem(
                  icon: Icons.mail,
                  label: "Quản lý tin",
                  index: 1,
                  currentIndex: currentIndex,
                  ref: ref,
                  user: user,
                ),

                const SizedBox(width: 40), // chỗ trống cho FAB
                // right
                _navItem(
                  icon: Icons.chat,
                  label: "Chat",
                  index: 3,
                  currentIndex: currentIndex,
                  ref: ref,
                  user: user,
                ),

                _navItem(
                  icon: Icons.person,
                  label: "Tài khoản",
                  index: 4,
                  currentIndex: currentIndex,
                  ref: ref,
                  user: user,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //widget item cho bottom nav bar

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
    required int currentIndex,
    required WidgetRef ref,
    required user,
  }) {
    final selected = currentIndex == index;
    final protectedIndex = [1,2, 3, 4, 5];

    return GestureDetector(
      onTap: () {
        print(index);
        if (protectedIndex.contains(index) && user == null) {
          ref.context.push(AppRouter.login);
          return;
        }
        ref.read(bottomNavProvider.notifier).changeTab(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: selected ? Colors.blue : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: selected ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
