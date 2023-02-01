import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userControllerProvider, (previous, next) {
      if (next is AsyncData) {
        context.go("/");
      }
    });
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
