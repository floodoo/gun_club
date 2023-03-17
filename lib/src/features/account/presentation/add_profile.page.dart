import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Füge deinen Profil hinzu",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 60),
              ),
            ),
            ref.watch(userControllerProvider).when(
                  data: (profile) {
                    return Form(
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
                                await ref.read(loginControllerProvider.notifier).updateUserProfile(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      dateOfBirth: dateOfBirth,
                                    );
                              }
                            },
                            child: const Text("Speichern"),
                          ),
                        ],
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
