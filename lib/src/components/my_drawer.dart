import 'package:flutter/material.dart';
import 'package:simplyputapp/src/components/list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOutTap;
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onSignOutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade100, // Light background for contrast
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                image: DecorationImage(
                  image: const NetworkImage(
                      'https://source.unsplash.com/random/?nature'), // Placeholder image
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              accountName: const Text('John Doe',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Outfit")),
              accountEmail: const Text('john.doe@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://source.unsplash.com/random/?portrait'), // Placeholder avatar
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildListTile(
                      context, 'User Profile', Icons.person, Colors.blue),
                  _buildListTile(
                      context, 'Settings', Icons.settings, Colors.green),
                  _buildListTile(
                      context, 'User Preferences', Icons.tune, Colors.orange),
                  Divider(color: Colors.grey[400]),
                  _buildListTile(
                      context, 'Logout', Icons.exit_to_app, Colors.red),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context, String title, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        // Handle navigation here
        Navigator.pop(context); // Close the drawer
        // Add navigation logic for each item
      },
    );
  }
}
