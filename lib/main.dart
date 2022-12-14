import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/config.dart';
import 'package:gun_club/global_providers.dart';
import 'package:gun_club/src/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGlobalProviders();
  await Supabase.initialize(url: baseURL, anonKey: anonKey);

  runApp(const ProviderScope(child: MyApp()));
}
