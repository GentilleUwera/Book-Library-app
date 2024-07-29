import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_notifier.dart';

class AppPreferenceScreen extends StatefulWidget {
  @override
  _AppPreferenceScreenState createState() => _AppPreferenceScreenState();
}

class _AppPreferenceScreenState extends State<AppPreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Preference')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<ThemeNotifier>(
              builder: (context, themeNotifier, child) {
                return SwitchListTile(
                  title: Text('Dark Mode'),
                  value: themeNotifier.isDarkMode,
                  onChanged: (bool value) {
                    themeNotifier.toggleTheme();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}