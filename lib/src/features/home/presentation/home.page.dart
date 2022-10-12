import 'package:flutter/material.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';

// TODO: Build real home page and delete prototype
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text("Home Page"),
          ElevatedButton(
            onPressed: () => supabase.auth.signOut(),
            child: const Text("SignOut"),
          ),
          Text(supabase.auth.currentUser?.email ?? "null"),
        ],
      ),
    );
  }
}
