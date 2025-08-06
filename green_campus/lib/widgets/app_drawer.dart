import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF197E46),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Color(0xFF197E46),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Student ID: 2023-123-456',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
              // Already on home screen
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.school,
            title: 'Academic',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Academic section coming soon!');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.restaurant,
            title: 'Canteen',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Canteen section coming soon!');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.directions_bus,
            title: 'Transport',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Transport section coming soon!');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.group,
            title: 'Clubs',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Clubs section coming soon!');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.info,
            title: 'Information',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Information section coming soon!');
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Settings coming soon!');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
              _showSnackBar(context, 'Help & Support coming soon!');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF197E46),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF197E46),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF197E46),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackBar(context, 'Logged out successfully!');
                // TODO: Implement actual logout logic
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
} 