import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("${profile.firstName} ${profile.lastName}"),
                          Text(profile.email),
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: const Text("Anmelden")),
                      DropdownButton(
                        value: profile.usertypeId,
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text("Member"),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Rentner Admin"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Admin"),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          ref
                              .read(adminControllerProvider.notifier)
                              .updateUserType(userId: profile.memberId, userTypeId: value);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
