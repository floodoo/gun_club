import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/extensions/date.extension.dart';
import 'package:gun_club/src/features/account/presentation/login.controller.dart';
import 'package:gun_club/src/features/admin/data/sources/dto/user_create.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, this.register = false});

  final bool register;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final dateOfBirthController = TextEditingController(text: DateTime.now().toDDMMYYYY());
    DateTime dateOfBirth = DateTime.now();
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text("Gun Club", style: theme.textTheme.displayLarge),
              const SizedBox(height: 50),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "Password"),
                    ),
                    const SizedBox(height: 10),
                    if (widget.register) ...[
                      Form(
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
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                    Row(
                      children: [
                        Text(
                          widget.register ? "Du hast einen Account?" : "Noch nicht registriert?",
                          style: theme.textTheme.bodySmall,
                        ),
                        TextButton(
                          onPressed: () => widget.register ? context.go("/login") : context.go("/register"),
                          child: Text(
                            widget.register ? "Anmelden" : "Registrieren",
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              widget.register
                  ? ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (formKey.currentState?.validate() ?? false) {
                                try {
                                  setState(() => isLoading = true);
                                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  await supabase.auth.signUp(email: email, password: password);
                                  await ref.read(loginControllerProvider.notifier).createUserProfile(
                                        user: UserCreateDto(
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          dateOfBirth: dateOfBirth,
                                          email: email,
                                          registeredSince: DateTime.now(),
                                        ),
                                      );
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Registrierung erfolgreich! Schau in deinem Postfach nach der Bestätigungsmail.",
                                      ),
                                    ),
                                  );
                                  emailController.clear();
                                  passwordController.clear();
                                  setState(() => isLoading = false);
                                } catch (e) {
                                  setState(() => isLoading = false);
                                  log(e.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                              }
                            },
                      child: const Text("Registrieren"),
                    )
                  : ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() => isLoading = true);
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              final goRouter = GoRouter.of(context);
                              try {
                                await supabase.auth.signInWithPassword(
                                  email: email.isEmpty ? null : email,
                                  password: password,
                                );
                                setState(() => isLoading = false);
                                goRouter.go("/start");
                              } on AuthException catch (e) {
                                setState(() => isLoading = false);
                                debugPrint(e.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.message),
                                  ),
                                );
                              } catch (e) {
                                setState(() => isLoading = false);
                                debugPrint(e.toString());
                              }
                            },
                      child: const Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
