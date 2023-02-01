import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gun_club/src/core/constants/supabase.constants.dart';
import 'package:gun_club/src/core/user/controller/user.controller.dart';
import 'package:gun_club/src/core/utils/user_type.util.dart';
import 'package:gun_club/src/features/gun_license/presentation/gun_license.page.dart';
import 'package:gun_club/src/features/profile/presentation/profile.page.dart';

class WebLayout extends ConsumerStatefulWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebLayoutState();
}

class _WebLayoutState extends ConsumerState<WebLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final child = IndexedStack(
      index: _selectedIndex,
      children: [
        const ProfilePage(),
        const Text("Kalender"),
        const GunLicensePage(),
        const Text("Report"),
        const Text("Statistik"),
        if (UserTypeUtil.getUserType(ref.read(userControllerProvider).asData?.value.usertypeId ?? 0) == UserType.admin)
          const Text("Admin"),
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
            destinations: [
              const NavigationRailDestination(
                icon: Icon(Icons.person_outline_outlined),
                selectedIcon: Icon(Icons.person),
                label: Text('Profile'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today),
                label: Text('Kalender'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.description_outlined),
                selectedIcon: Icon(Icons.description),
                label: Text('Lizenzen'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.flag_outlined),
                selectedIcon: Icon(Icons.flag),
                label: Text('Report'),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.stacked_line_chart_outlined),
                selectedIcon: Icon(Icons.stacked_line_chart),
                label: Text('Statistik'),
              ),
              if (UserTypeUtil.getUserType(ref.read(userControllerProvider).asData?.value.usertypeId ?? 0) ==
                  UserType.admin)
                const NavigationRailDestination(
                  icon: Icon(Icons.admin_panel_settings_outlined),
                  selectedIcon: Icon(Icons.admin_panel_settings),
                  label: Text('Admin'),
                ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: Center(child: child)),
        ],
      ),
    );
  }
}
