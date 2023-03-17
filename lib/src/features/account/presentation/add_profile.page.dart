import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/extensions/date.extension.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';
import 'package:gun_club/src/features/account/presentation/login.controller.dart';

class AddProfilePage extends ConsumerStatefulWidget {
  const AddProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends ConsumerState<AddProfilePage> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController(text: DateTime.now().toDDMMYYYY());
  DateTime dateOfBirth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Füge dein Profil hinzu",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 60),
              ),
            ),
            ref.watch(userControllerProvider).when(
                  data: (profile) {
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Form(
                        key: formKey,
                        child: Column(
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
                            const SizedBox(height: 50),
                            ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  final goRouter = GoRouter.of(context);
                                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                                  try {
                                    await ref.read(loginControllerProvider.notifier).updateUserProfile(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          dateOfBirth: dateOfBirth,
                                        );
                                    scaffoldMessenger.showSnackBar(
                                      const SnackBar(
                                        content: Text("Dein Profil wurde erfolgreich hinzugefügt"),
                                      ),
                                    );
                                    goRouter.go("/");
                                  } catch (e) {
                                    scaffoldMessenger.showSnackBar(
                                      const SnackBar(
                                        content: Text("Es ist ein Fehler aufgetreten"),
                                      ),
                                    );
                                    log(e.toString());
                                  }
                                }
                              },
                              child: const Text("Speichern"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text(error.toString()),
                ),
          ],
        ),
      ),
    );
  }
}
