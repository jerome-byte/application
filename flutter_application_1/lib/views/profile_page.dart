import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = Provider.of<AuthController>(context, listen: false);
    if (auth.user != null) _nameController.text = auth.user!.name;
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _loading = true);
    final auth = Provider.of<AuthController>(context, listen: false);
    await auth.updateProfile(name: _nameController.text.trim());
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil mis à jour')));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final user = auth.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: user == null
          ? const Center(child: Text('Aucun utilisateur connecté'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(radius: 44, child: Text(user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : '?', style: const TextStyle(fontSize: 28))),
                  const SizedBox(height: 12),
                  Text(user.email, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nom'), validator: (v) => (v != null && v.trim().isNotEmpty) ? null : 'Obligatoire'),
                            const SizedBox(height: 16),
                            SizedBox(
                                width: double.infinity,
                                child: _loading ? const Center(child: CircularProgressIndicator()) : ElevatedButton(onPressed: _save, child: const Text('Enregistrer'))),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
