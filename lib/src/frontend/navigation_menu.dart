import 'package:flutter/material.dart';
import 'package:simplyputapp/src/components/my_drawer.dart';
import 'package:simplyputapp/src/frontend/home.dart';
import 'package:simplyputapp/src/frontend/profile.dart';
import 'package:simplyputapp/src/frontend/books.dart';
import 'package:simplyputapp/src/frontend/home_works.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:simplyputapp/src/frontend/signout_page.dart';

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

  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserProfile()));
  }

  void goToSignOutPage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignOutPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffff6961),
                  spreadRadius: 1,
                  blurRadius: 4,
                )
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.red.shade300])),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 219, 201),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOutTap: goToSignOutPage,
      ),
      drawerEnableOpenDragGesture: true,
      body: Scaffold(
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
