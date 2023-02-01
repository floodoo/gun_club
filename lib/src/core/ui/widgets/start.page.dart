import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  Future<void> navigateToHome(BuildContext context) async {
    final goRouter = GoRouter.of(context);
    // Hack to wait for the user. This is a temporary solution.
    await Future.delayed(const Duration(milliseconds: 500));
    goRouter.go('/');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ref.watch(userControllerProvider).when(
            data: (user) {
              navigateToHome(context);
              return const CircularProgressIndicator();
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text(error.toString()),
          ),
    );
  }
}
