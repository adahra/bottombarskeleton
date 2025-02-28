import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_bottom_nav/providers/app_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final appProvider = Provider.of<AppProvider>(context, listen: false);
    _controller.text = appProvider.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final appProvider = Provider.of<AppProvider>(
                  context,
                  listen: false,
                );
                appProvider.updateUsername(_controller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Nama berhasil diperbarui!")),
                );
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
