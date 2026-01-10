import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/router_provider.dart';
import 'package:rent_connect/features/auth/views/bottom_nav_screen.dart';
import 'package:rent_connect/features/auth/views/home/home_screen.dart';
import 'package:rent_connect/features/auth/views/login_screen.dart';
import 'package:rent_connect/features/auth/views/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(
    ProviderScope(
      child: AuthInit(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Rent Connect',
      routerConfig: router ,
      debugShowCheckedModeBanner: false,
    );
  }
  
}
class AuthInit extends ConsumerStatefulWidget {
  final Widget child;
  const AuthInit({super.key, required this.child});

  @override
  ConsumerState<AuthInit> createState() => _AuthInitState();
}

class _AuthInitState extends ConsumerState<AuthInit> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authControllerProvider.notifier).restoreSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

