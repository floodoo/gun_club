import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gun_club/router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    supabaseInit();

    supabase.auth.onAuthStateChange.listen(
      (data) {
        final AuthChangeEvent event = data.event;
        debugPrint("SUPABASE AUTH-EVENT: $event");
        switch (event) {
          case AuthChangeEvent.signedIn:
            break;
          case AuthChangeEvent.signedOut:
            break;
          default:
            break;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: "Schützenverein Verwaltung",
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
        brightness: Brightness.dark,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: kIsWeb
              ? {
                  // No animations for every OS if the app running on the web
                  for (final platform in TargetPlatform.values) platform: const NoTransitionsBuilder(),
                }
              : const {},
        ),
        cardTheme: const CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

Future<void> supabaseInit() async {
  try {
    final initialSession = await SupabaseAuth.instance.initialSession;
    debugPrint('SUPABASE INITIAL SESSION: ${initialSession != null ? true : false}');
  } catch (e) {
    debugPrint('ERROR: SUPABASE INITIAL SESSION FAILED: $e');
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}
