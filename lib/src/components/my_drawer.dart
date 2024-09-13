import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simplyputapp/src/frontend/profile.dart';

class MyDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userAvatarUrl;
  final String headerBackgroundImageUrl;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onPreferencesTap;
  final VoidCallback? onSignOutTap;
  final String appVersion;

  const MyDrawer({
    Key? key,
    this.userName = 'User Name',
    this.userEmail = 'user@example.com',
    this.userAvatarUrl =
        'https://plus.unsplash.com/premium_photo-1710911198710-3097c518f0e1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    this.headerBackgroundImageUrl =
        'https://source.unsplash.com/random/?nature',
    this.onProfileTap,
    this.onSettingsTap,
    this.onPreferencesTap,
    this.onSignOutTap,
    this.appVersion = '1.0.0',
  }) : super(key: key);

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              height: 220,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Colors.red.shade700,
                  image: DecorationImage(
                    image: NetworkImage(headerBackgroundImageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
                accountName: Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Outfit",
                  ),
                ),
                accountEmail: Text(userEmail),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(userAvatarUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  CustomListTile(
                    title: 'User Profile',
                    icon: Icons.person,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()));
                    },
                  ),
                  CustomListTile(
                    title: 'Settings',
                    icon: Icons.settings,
                    color: Colors.green,
                    onTap: onSettingsTap,
                  ),
                  CustomListTile(
                    title: 'User Preferences',
                    icon: Icons.tune,
                    color: Colors.orange,
                    onTap: onPreferencesTap,
                  ),
                  const Divider(color: Colors.grey),
                  CustomListTile(
                    title: 'Logout',
                    icon: Icons.exit_to_app,
                    color: Colors.red,
                    onTap: signUserOut,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'App Version $appVersion',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap != null
          ? () {
              Navigator.pop(context);
              onTap!();
            }
          : null,
    );
  }
}
