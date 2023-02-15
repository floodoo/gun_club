import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  @override
  void initState() {
    if (supabase.auth.currentUser != null) {
      ref.read(userControllerProvider);
    }

    log("START PAGE INIT");
    log("Start Page - Current User: ${supabase.auth.currentUser?.toJson()}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userControllerProvider, (previous, next) {
      log("Start Page - User Controller: $next");

      if (next is AsyncError) {
        final error = next as AsyncError;
        throw error.error;
      }
      if (next is AsyncData) {
        context.go("/");
      }
    });
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
