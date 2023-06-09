import 'package:dehas_admin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      lightTheme: SettingsThemeData(
          titleTextColor: Colors.red, settingsListBackground: Colors.red[100]),
      sections: [
        SettingsSection(
          title: const Text('Settings'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              title: const Text('Sign Out'),
              onPressed: (a) => auth.signOut(),
              leading: const Icon(Icons.logout),
            ),
            SettingsTile.navigation(
              title: const Text('About'),
              leading: const Icon(Icons.info),
            ),
          ],
        ),
      ],
    );
  }
}
