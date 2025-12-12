import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/core/providers/user_provider.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/features/auth/views/add_post_screen.dart';
import 'package:rent_connect/features/auth/views/bottom_nav_screen.dart';
import 'package:rent_connect/features/auth/views/chat_screen.dart';
import 'package:rent_connect/features/auth/views/details_post_screen.dart';
import 'package:rent_connect/features/auth/views/login_screen.dart';
import 'package:rent_connect/features/auth/views/manage_post_screen.dart';
import 'package:rent_connect/features/auth/views/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(userProvider);
  return GoRouter(
    initialLocation: AppRouter.home,
    redirect: (context, state) {
      final loggedIn = user != null;
      final loggingIn = state.uri.path == AppRouter.login;

      if (!loggedIn && AppRouter.protected.contains(state.uri.path)) {
        return AppRouter.login;
      }

      if (loggedIn && loggingIn) {
        return AppRouter.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRouter.home,
        builder: (context, state) => const BottomNavScreen(),
      ),
      GoRoute(
        path: AppRouter.managePost,
        builder: (context, state) => const ManagePostScreen(),
      ),
      GoRoute(
        path: AppRouter.addPost,
        builder: (context, state) => const AddPostScreen(),
      ),
      GoRoute(
        path: AppRouter.chat,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: AppRouter.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRouter.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRouter.detailsPost,
        name: AppRouter.detailsPost,
        builder: (context, state) {
          final postId = state.uri.queryParameters['postId']!;
          return DetailsPostScreen(postId: postId);
        },
      ),
    ],
  );
});
