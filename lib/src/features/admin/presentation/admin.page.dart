import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/user/data/sources/dto/user.dto.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';
import 'package:gun_club/src/features/admin/presentation/department.controller.dart';
import 'package:gun_club/src/features/admin/presentation/widgets/create_user_dialog.dart';
import 'package:gun_club/src/features/admin/presentation/widgets/department_dialog.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ref.watch(adminControllerProvider).when(
          data: (profiles) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async => await showCreateUserDialog(context),
                child: const Icon(Icons.add),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text("User Verwaltung", style: theme.textTheme.displayLarge?.copyWith(fontSize: 60)),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Suche',
                                suffixIcon: Icon(Icons.search),
                              ),
                              onSubmitted: (String value) async {
                                await ref.read(adminControllerProvider.notifier).getUserProfileBySearch(serach: value);
                              },
                            ),
                          ),
                          const SizedBox(width: 50),
                          IconButton(
                            onPressed: () async {
                              await ref.read(adminControllerProvider.notifier).resetSearch();
                            },
                            icon: const Icon(Icons.cancel_outlined),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      ListView.separated(
                        itemCount: profiles.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final UserDto profile = profiles[index];

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 50,
                                  mainAxisExtent: 50,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${profile.firstName} ${profile.lastName}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                      Text(
                                        profile.email ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () async => await showDepartmentDialog(context, profile),
                                    child: const Text("Anmelden"),
                                  ),
                                  DropdownButton(
                                    value: profile.usertypeId,
                                    isExpanded: true,
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
                                  ref.watch(departmentControllerProvider).when(
                                        data: (departments) {
                                          return DropdownButton(
                                            value: profile.departmentId,
                                            isExpanded: true,
                                            items: departments
                                                .map(
                                                  (department) => DropdownMenuItem(
                                                    value: department.departmentId,
                                                    child: Text(department.name),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (value) {
                                              if (value == null) return;

                                              ref
                                                  .read(departmentControllerProvider.notifier)
                                                  .updateUserDepartment(userId: profile.memberId, departmentId: value);
                                            },
                                          );
                                        },
                                        loading: () => const Center(child: CircularProgressIndicator()),
                                        error: (error, stack) => const Center(child: Text("Fehler")),
                                      ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("${profile.firstName} ${profile.lastName} Löschen"),
                                          content: Text(
                                            "Möchten Sie den User ${profile.firstName} ${profile.lastName} wirklich löschen?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Abbrechen"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                ref
                                                    .read(adminControllerProvider.notifier)
                                                    .deleteUser(userId: profile.memberId);
                                              },
                                              child: const Text("Löschen"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                    child: const Text("Löschen"),
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
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
