import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider_bottom_nav/bottom_nav_bar.dart';
import 'package:provider_bottom_nav/localizations/app_localizations.dart';
import 'package:provider_bottom_nav/providers/app_provider.dart';
import 'package:provider_bottom_nav/providers/counter_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appProvider = AppProvider();
  await appProvider.loadPreferences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => appProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: appProvider.locale,
          supportedLocales: [Locale('en', 'US'), Locale('id', 'ID')],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            brightness:
                appProvider.isDarkMode ? Brightness.dark : Brightness.light,
            primaryColor: _getMaterialColor(appProvider.themeColor),
            primarySwatch: _getMaterialColor(appProvider.themeColor),
          ),
          home: BottomNavBar(),
        );
      },
    );
  }

  MaterialColor _getMaterialColor(Color themeColor) {
    return MaterialColor(themeColor.value, {
      50: themeColor.withOpacity(0.1),
      100: themeColor.withOpacity(0.2),
      200: themeColor.withOpacity(0.3),
      300: themeColor.withOpacity(0.4),
      400: themeColor.withOpacity(0.5),
      500: themeColor.withOpacity(0.6),
      600: themeColor.withOpacity(0.7),
      700: themeColor.withOpacity(0.8),
      800: themeColor.withOpacity(0.9),
      900: themeColor.withOpacity(1.0),
    });
  }
}
