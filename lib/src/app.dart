import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/config.dart';
import 'package:gun_club/router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // TODO: Currentlly you can just change the url and it navigates to homepage(when not logged in). This should redirect on login page.
    supabase.auth.onAuthStateChange(
      (event, session) {
        debugPrint("SUPABASE AUTH-EVENT: $event");
        switch (event) {
          case AuthChangeEvent.signedIn:
            router.go("/");
            break;
          case AuthChangeEvent.signedOut:
            router.go("/login");
            break;
          default:
            break;
        }
      },
    );

    return MaterialApp.router(
      title: "Schützenverein Verwaltung", // TODO: Change name
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: !isProduction,
      // TODO: Theming
      // TODO: Localizations
    );
  }
}
