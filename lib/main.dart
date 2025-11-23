import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/views/home/home_screen.dart';
import 'package:rent_connect/features/auth/views/login_screen.dart';
import 'package:rent_connect/features/auth/views/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(url: dotenv.env['SUPABASE_URL']!, anonKey: dotenv.env[ 'SUPABASE_ANON_KEY']!);
  runApp(ProviderScope(child: MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  )));
}

