import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/utils/user_type.util.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(adminControllerProvider).when(
          data: (profiles) {
            return ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return ListTile(
                  title: Text("${profile.firstName} ${profile.lastName}"),
                  subtitle: Text(profile.email),
                  trailing: Text(UserTypeUtil.getUserType(profile.usertypeId).toString()),
                );
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
