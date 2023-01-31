import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.register = false}) : super(key: key);

  final bool register;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text("Gun Club", style: theme.textTheme.headline1),
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
                    Row(
                      children: [
                        Text(widget.register ? "Du hast einen Account?" : "Noch nicht registriert?",
                            style: theme.textTheme.caption),
                        TextButton(
                          onPressed: () => widget.register ? context.go("/login") : context.go("/register"),
                          child: Text(
                            widget.register ? "Anmelden" : "Registrieren",
                            style: theme.textTheme.caption?.copyWith(color: theme.colorScheme.secondary),
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
                              try {
                                setState(() => isLoading = true);
                                final scaffoldMessenger = ScaffoldMessenger.of(context);
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                await supabase.auth.signUp(email: email, password: password);
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
                              try {
                                await supabase.auth.signInWithPassword(email: email, password: password);
                                setState(() => isLoading = false);
                                context.go("/");
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
