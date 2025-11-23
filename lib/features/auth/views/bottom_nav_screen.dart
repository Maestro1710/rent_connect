import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/bottom_nav_provider.dart';
import 'package:rent_connect/features/auth/views/chat_screen.dart';
import 'package:rent_connect/features/auth/views/home/home_screen.dart';
import 'package:rent_connect/features/auth/views/manage_post_screen.dart';
import 'package:rent_connect/features/auth/views/profile_screen.dart';

class BottomNavScreen extends ConsumerWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
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
          //dieu huong den trang them bai dang
        },
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        height: 72,
        child: SizedBox(height: 60, child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            _navItem(
              icon: Icons.home,
              label: "Trang chủ",
              index: 0,
              currentIndex: currentIndex,
              ref: ref,
            ),

            _navItem(
              icon: Icons.mail,
              label: "Quản lý tin",
              index: 1,
              currentIndex: currentIndex,
              ref: ref,
            ),

            const SizedBox(width: 40), // chỗ trống cho FAB

            // right
            _navItem(
              icon: Icons.chat,
              label: "Chat",
              index: 3,
              currentIndex: currentIndex,
              ref: ref,
            ),

            _navItem(
              icon: Icons.person,
              label: "Tài khoản",
              index: 4,
              currentIndex: currentIndex,
              ref: ref,
            ),
          ],
        )),
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
  }) {
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () => ref.read(bottomNavProvider.notifier).state = index,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: selected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: selected ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
