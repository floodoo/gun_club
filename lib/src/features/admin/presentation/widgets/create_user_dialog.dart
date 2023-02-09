import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/src/core/extensions/date.extension.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_create.dto.dart';
import 'package:gun_club/src/features/admin/presentation/admin.controller.dart';

Future<void> showCreateUserDialog(BuildContext context) {
  return showDialog(
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
}
