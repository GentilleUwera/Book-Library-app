import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Account')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Change Name'),
              onTap: () {
                // Handle change name
              },
            ),
            ListTile(
              title: Text('Change Username'),
              onTap: () {
                // Handle change username
              },
            ),
            ListTile(
              title: Text('Change Email'),
              onTap: () {
                // Handle change email
              },
            ),
            ListTile(
              title: Text('Delete Account'),
              onTap: () {
                // Handle account deletion
              },
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                // Handle help
              },
            ),
          ],
        ),
      ),
    );
  }
}