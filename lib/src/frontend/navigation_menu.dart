import 'package:flutter/material.dart';
import 'package:simplyputapp/src/frontend/home.dart';
import 'package:simplyputapp/src/frontend/profile.dart';
import 'package:simplyputapp/src/frontend/books.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _pageIndex = 0;
  final List<Widget> _tabList = [
    const Home(),
    const Book(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _tabList.elementAt(_pageIndex),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
            alignment: const Alignment(0.0, 1.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: BottomNavigationBar(
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade300,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                backgroundColor: const Color.fromARGB(255, 31, 30, 30),
                currentIndex: _pageIndex,
                onTap: (int index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.upload_file), label: "upload"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "profile"),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
