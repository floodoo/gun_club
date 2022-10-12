import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/global_providers.dart';
import 'package:gun_club/src/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGlobalProviders();
  await Supabase.initialize(
    url: "https://uuhvsgyassyghpddztxd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV1aHZzZ3lhc3N5Z2hwZGR6dHhkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU1NTgyMTYsImV4cCI6MTk4MTEzNDIxNn0.KabQNBBLwDp-_D1pG1RFsu8OX-yr6p0dwl2wyG4lSE0",
  );

  runApp(const ProviderScope(child: MyApp()));
}
