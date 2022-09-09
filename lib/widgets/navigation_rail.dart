import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WidgetNavigationRail extends StatelessWidget {
  WidgetNavigationRail({
    Key? key,
    required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        // setState(() {
        //   _selectedIndex = index;
        // });
        if (index == 0) {
          context.go('/nyumba');
        } else if (index == 1) {
          context.go('/statement');
        } else if (index == 2) {
          context.go('/invoice');
        } else if (index == 3) {
          context.go('/letters');
        } else if (index == 4) {
          context.go('/occupancy');
        } else if (index == 5) {
          context.go('/complaints');
        }
      },
      leading: const CircleAvatar(
        radius: 40,
        foregroundImage: AssetImage('assets/icons/vidic.png'),
      ),
      // labelType: NavigationRailLabelType.all,
      extended: true,
      minExtendedWidth: 170,
      useIndicator: true,
      indicatorColor: Colors.purple[300],
      backgroundColor: Colors.white,
      destinations: <NavigationRailDestination>[
        // navigation destinations
        // int i;,
        // for (var i=0; i<3; i++){
        //   NavigationRailDestination(
        //     icon: Icon(Icons.favorite_border),
        //     selectedIcon: Icon(Icons.favorite),
        //     label: Text('Wishlist'),
        //   ),
        // },
        newMethodDestination(
          icon: Icons.home,
          selIcon: Icons.home_outlined,
          label: 'Home',
        ),
        newMethodDestination(
          icon: Icons.list,
          selIcon: Icons.list,
          label: 'Statement',
        ),
        // NavigationRailDestination(
        //   icon: Icon(Icons.list),
        //   selectedIcon: Icon(
        //     Icons.list,
        //     color: Colors.black,
        //   ),
        //   label: Text('Statement'),
        // ),
        newMethodDestination(
          icon: Icons.attach_money,
          selIcon: Icons.attach_money,
          label: 'Invoice',
        ),
        newMethodDestination(
          icon: Icons.edit_note,
          selIcon: Icons.mode_edit,
          label: 'Letters',
        ),

        newMethodDestination(
          icon: Icons.business,
          selIcon: Icons.business_outlined,
          label: 'Occupancy',
        ),
        newMethodDestination(
          icon: Icons.report_problem,
          selIcon: Icons.report_problem_outlined,
          label: 'Complaints',
        ),
      ],
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      selectedLabelTextStyle: const TextStyle(color: Colors.white),
    );
  }

  NavigationRailDestination newMethodDestination({
    required IconData icon,
    required String label,
    required IconData selIcon,
  }) {
    // IconData ico = Icons.home;
    // print(label);
    return NavigationRailDestination(
      padding: const EdgeInsets.all(0),
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      selectedIcon: Icon(
        selIcon,
        color: Colors.black,
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
