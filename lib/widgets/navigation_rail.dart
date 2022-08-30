import 'package:flutter/material.dart';

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
      },
      labelType: NavigationRailLabelType.selected,
      backgroundColor: Colors.green,
      destinations: const <NavigationRailDestination>[
        // navigation destinations
        // int i;,
        // for (var i=0; i<3; i++){
        //   NavigationRailDestination(
        //     icon: Icon(Icons.favorite_border),
        //     selectedIcon: Icon(Icons.favorite),
        //     label: Text('Wishlist'),
        //   ),
        // },
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('Wishlist'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person),
          label: Text('Account'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.shopping_cart_outlined),
          selectedIcon: Icon(Icons.shopping_cart),
          label: Text('Cart'),
        ),
      ],
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      selectedLabelTextStyle: const TextStyle(color: Colors.white),
    );
  }
}
