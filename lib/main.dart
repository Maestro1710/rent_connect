import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/features/auth/views/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print("SUPABASE_URL = ${dotenv.env['SUPABASE_URL']}");
  print("SUPABASE_ANON_KEY = ${dotenv.env['SUPABASE_ANON_KEY']?.substring(0,10)}...");
  await Supabase.initialize(url: dotenv.env['SUPABASE_URL']!, anonKey: dotenv.env[ 'SUPABASE_ANON_KEY']!);
  runApp(ProviderScope(child: MaterialApp(
    home: RegisterScreen(),
    debugShowCheckedModeBanner: false,
  )));
}

