import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/theme_controller.dart';
import 'login_page.dart';
import 'profile_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final theme = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  auth.user != null
                      ? auth.user!.name.substring(0, 1).toUpperCase()
                      : '?',
                ),
              ),
              title: Text(auth.user?.name ?? 'Invité'),
              subtitle: Text(auth.user?.email ?? 'Non connecté'),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfilePage())),
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Notifications'),
          ),
          SwitchListTile(
            value: theme.isDark,
            onChanged: (_) => theme.toggle(),
            title: const Text('Mode sombre'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Se déconnecter'),
            onTap: () {
              auth.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
