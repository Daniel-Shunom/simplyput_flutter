import 'package:flutter/material.dart';
import 'package:simplyputapp/src/frontend/home.dart';
import 'package:simplyputapp/src/frontend/profile.dart';
import 'package:simplyputapp/src/frontend/books.dart';
import 'package:simplyputapp/src/frontend/home_works.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  final List<Widget> tabItems = [
    const HomePage(),
    const Homework(),
    const Book(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: tabItems[_selectedIndex],
        ),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: Image.asset(
                "assets/images/tab_home.png",
                color: const Color(0xff9496c1),
                width: 30,
              ),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              icon: Image.asset(
                "assets/images/tab_homework.png",
                color: const Color(0xff9496c1),
                width: 30,
              ),
              title: const Text('Homework'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.event),
              title: const Text('Events'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.person_2_rounded),
              title: const Text('profile'),
            ),
          ],
        ),
      ),
    );
  }
}
