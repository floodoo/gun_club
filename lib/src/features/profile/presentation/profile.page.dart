import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/features/profile/presentation/profile.controller.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(profileControllerProvider).when(
          data: (profile) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(profile.firstName),
                  Text(profile.lastName),
                  Text(profile.dateOfBirth.toString()),
                  Text(profile.registeredSince.toString())
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
