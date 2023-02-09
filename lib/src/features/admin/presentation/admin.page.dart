import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/extensions/date.extension.dart';
import 'package:gun_club/src/core/user/data/sources/dto/user.dto.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_create.dto.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final formKey = GlobalKey<FormState>();
                          final firstNameController = TextEditingController();
                          final lastNameController = TextEditingController();
                          final dateOfBirthController = TextEditingController(text: DateTime.now().toDDMMYYYY());
                          final emailController = TextEditingController();

                          DateTime dateOfBirth = DateTime.now();

                          return AlertDialog(
                            title: const Text("User erstellen"),
                            content: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: firstNameController,
                                    decoration: const InputDecoration(labelText: "Vorname"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Bitte einen Vornamen eingeben";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: lastNameController,
                                    decoration: const InputDecoration(labelText: "Nachname"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Bitte einen Nachnamen eingeben";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(labelText: "Email (optional)"),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: dateOfBirthController,
                                    readOnly: true,
                                    onTap: () async {
                                      final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );

                                      if (picked != null) {
                                        dateOfBirth = picked;
                                        dateOfBirthController.text = picked.toDDMMYYYY();
                                      }
                                    },
                                    decoration: const InputDecoration(labelText: "Geburtsdatum"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty || dateOfBirth.isAfter(DateTime.now())) {
                                        return "Bitte ein Geburtsdatum eingeben";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Abbrechen"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ?? false) {
                                    final navigator = Navigator.of(context);

                                    await ref.read(adminControllerProvider.notifier).createUser(
                                          user: UserCreateDto(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            dateOfBirth: dateOfBirth,
                                            registeredSince: DateTime.now(),
                                            email: emailController.text,
                                          ),
                                        );

                                    navigator.pop();
                                  }
                                },
                                child: const Text("Erstellen"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
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
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }

                          final suggestedUser = profiles.where((profile) {
                            final name = "${profile.firstName} ${profile.lastName}".toLowerCase();
                            final search = textEditingValue.text.toLowerCase();

                            return name.contains(search);
                          }).toList();

                          return suggestedUser.map((user) => "${user.firstName} ${user.lastName}");
                        },
                        fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: 'Suche',
                              suffixIcon: Icon(Icons.search),
                            ),
                            onSubmitted: (String value) async {
                              await ref.read(adminControllerProvider.notifier).getUserProfileBySearch(serach: value);
                            },
                          );
                        },
                        onSelected: (String selection) async {
                          await ref.read(adminControllerProvider.notifier).getUserProfileBySearch(serach: selection);
                        },
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
                                  crossAxisCount: 4,
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
                                    onPressed: () async {
                                      await showDepartmentDialog(context, profile);
                                    },
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
                                  ElevatedButton(
                                    onPressed: () {
                                      ref.read(adminControllerProvider.notifier).deleteUser(userId: profile.memberId);
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
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text(error.toString()),
        );
  }
}
