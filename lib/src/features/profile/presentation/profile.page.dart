import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';
import 'package:gun_club/src/features/profile/presentation/profile.controller.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ref.watch(userControllerProvider).when(
                data: (profile) {
                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, size: 100, color: Colors.white),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            profile.firstName,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            profile.lastName,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        profile.email,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Mitglied seit: ${profile.registeredSince}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Divider(),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text(error.toString()),
              ),
          ref.watch(profileControllerProvider).when(
                data: (attendances) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Besichtigungen: ${attendances.length}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 400,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: attendances.length,
                          itemBuilder: (context, index) {
                            final attendance = attendances[index];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(attendance.department.name),
                                    const Spacer(),
                                    Text(attendance.timestamp.toLocal().toString()),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  );
                },
                error: (error, stack) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
        ],
      ),
    );
  }
}
