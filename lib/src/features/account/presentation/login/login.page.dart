import 'package:flutter/material.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';

// TODO: Build real login page and delete prototype
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text("Login Page"),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              supabase.auth.signIn(email: email, password: password);
            },
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              supabase.auth.signUp(email, password);
            },
            child: const Text("Registrieren"),
          ),
        ],
      ),
    );
  }
}
