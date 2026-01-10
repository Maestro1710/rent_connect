import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_connect/core/providers/auth_state_provider.dart';
import 'package:rent_connect/core/providers/router_refresh.dart';
import 'package:rent_connect/core/providers/user_provider.dart';
import 'package:rent_connect/app_router.dart';
import 'package:rent_connect/features/auth/views/add_post_screen.dart';
import 'package:rent_connect/features/auth/views/bottom_nav_screen.dart';
import 'package:rent_connect/features/auth/views/chat_screen.dart';
import 'package:rent_connect/features/auth/views/details_post_screen.dart';
import 'package:rent_connect/features/auth/views/login_screen.dart';
import 'package:rent_connect/features/auth/views/manage_post/manage_post_detail_screen.dart';
import 'package:rent_connect/features/auth/views/manage_post/manage_post_screen.dart';
import 'package:rent_connect/features/auth/views/profile_screen.dart';
import 'package:rent_connect/features/auth/views/search_screen.dart';
import 'package:rent_connect/features/auth/views/update_post_sceen.dart';

import '../../features/auth/model/user_model.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = GoRouterRefreshNotifier(ref);
  return GoRouter(
    initialLocation: AppRouter.home,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final loggedIn = ref.watch(authStateProvider);
      final path = state.uri.path;

      final isProtected = AppRouter.protected.any((p) => path.startsWith(p));

      if (!loggedIn && isProtected) {
        return AppRouter.login;
      }

      if (loggedIn && path == AppRouter.login) {
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
      GoRoute(
        path: '${AppRouter.manageDetailPost}/:id',
        name: AppRouter.manageDetailPost,
        builder: (context, state) {
          final postId = state.pathParameters['id']!;
          return ManagePostDetailScreen(postId: postId);
        },
      ),
      GoRoute(
        path: '${AppRouter.updatePost}/:id',
        name: AppRouter.updatePost,
        builder: (context, state) {
          final postId = state.pathParameters['id'];
          return UpdatePostScreen(postId: postId!);
        },
      ),
      GoRoute(path: AppRouter.search,name: AppRouter.search,
        builder: (context, state) => SearchScreen(),
      )
    ],
  );
});
