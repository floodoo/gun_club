import 'package:flutter/material.dart';

// TODO: Build real home page and delete prototype
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: 0,
            onDestinationSelected: (int index) {},
            labelType: NavigationRailLabelType.all,
            trailing: IconButton(
              icon: const Icon(Icons.logout_outlined, color: Colors.red),
              onPressed: () {},
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
          // This is the main content.
          const Expanded(
            child: Center(
              child: Text('Rail Content'),
            ),
          )
        ],
      ),
    );
  }
}
