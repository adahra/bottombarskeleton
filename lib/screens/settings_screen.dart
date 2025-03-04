import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_bottom_nav/localizations/app_localizations.dart';
import 'package:provider_bottom_nav/providers/app_provider.dart';
import 'package:provider_bottom_nav/screens/profile_page.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              subtitle: Text(appProvider.username),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text("Pilih Warna Tema"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Wrap(
                spacing: 10,
                children:
                    colors.map((color) {
                      return GestureDetector(
                        onTap: () => appProvider.changeTheme(color),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  appProvider.themeColor == color
                                      ? Colors.black
                                      : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text("Mode Gelap"),
              trailing: Switch(
                value: appProvider.isDarkMode,
                onChanged: (value) {
                  appProvider.toggleDarkMode(value);
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(lang.translate("language")),
              trailing: DropdownButton(
                items: [
                  DropdownMenuItem(value: Locale('en'), child: Text("English")),
                  DropdownMenuItem(
                    value: Locale('id'),
                    child: Text('Bahasa Indonesia'),
                  ),
                ],
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    appProvider.changeLanguage(newLocale);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
