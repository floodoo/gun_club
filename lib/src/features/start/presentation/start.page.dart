import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ref.watch(userControllerProvider).when(
            data: (user) {
              context.go('/');
              return const CircularProgressIndicator();
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
    );
  }
}
