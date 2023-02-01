import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/ui/widgets/web_layout.dart';
import 'package:gun_club/src/features/account/presentation/login/login.page.dart';
import 'package:gun_club/src/features/start/presentation/start.page.dart';

final routerProvider = Provider<GoRouter>((ref) => _goRouter);
final _goRouter = GoRouter(
  debugLogDiagnostics: kDebugMode ? true : false,
  initialLocation: "/start",
  redirect: (context, state) {
    if (supabase.auth.currentUser == null && state.location != "/login" && state.location != "/register") {
      return "/login";
    }

    if (supabase.auth.currentUser != null &&
        (state.location == "/login" || state.location == "/register" || state.location.contains("access_token"))) {
      return "/start";
    }

    return null;
  },
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const WebLayout(),
    ),
    GoRoute(
      path: '/start',
      pageBuilder: (context, state) => const MaterialPage(child: StartPage()),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => const LoginPage(register: true),
    ),
  ],
);
