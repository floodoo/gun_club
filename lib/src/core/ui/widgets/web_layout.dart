import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/features/profile/presentation/profile.page.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final child = IndexedStack(
      index: _selectedIndex,
      children: const [
        ProfilePage(),
        Text("Kalender"),
        Text("Lizenzen"),
        Text("Report"),
        Text("Statistik"),
      ],
    );

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.logout_outlined, color: Colors.red.shade700),
                    onPressed: () async {
                      final goRouter = GoRouter.of(context);
                      await supabase.auth.signOut();
                      goRouter.go("/login");
                    },
                  ),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.person_outline_outlined),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today),
                label: Text('Kalender'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.description_outlined),
                selectedIcon: Icon(Icons.description),
                label: Text('Lizenzen'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.flag_outlined),
                selectedIcon: Icon(Icons.flag),
                label: Text('Report'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.stacked_line_chart_outlined),
                selectedIcon: Icon(Icons.stacked_line_chart),
                label: Text('Statistik'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
