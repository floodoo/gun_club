import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';
import 'package:gun_club/src/features/admin/presentation/widgets/department_dialog.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ref.watch(adminControllerProvider).when(
          data: (profiles) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text("User Verwaltung", style: theme.textTheme.headline1?.copyWith(fontSize: 60)),
                    const SizedBox(height: 50),
                    ListView.separated(
                      itemCount: profiles.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final profile = profiles[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Text("${profile.firstName} ${profile.lastName}"),
                                      Text(profile.email),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      showDepartmentDialog(context, profile);
                                    },
                                    child: const Text("Anmelden"),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: DropdownButton(
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
