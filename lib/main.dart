import 'package:flutter/material.dart';

import 'core/language.dart';
import 'core/shared_prefs.dart';
import 'core/theme.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark = await SharedPrefs.getThemeMode();
  final langCode = await SharedPrefs.getLanguageCode();
  runApp(MyApp(isDark: isDark, langCode: langCode));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  final String langCode;

  const MyApp({super.key, required this.isDark, required this.langCode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDark;
  late String _langCode;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
    _langCode = widget.langCode;
  }

  void _updateTheme(bool isDark) {
    setState(() => _isDark = isDark);
  }

  void _updateLanguage(String langCode) {
    setState(() => _langCode = langCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: SimpleLocalization.getText('appTitle', _langCode),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: SettingsScreen(
        onThemeChanged: _updateTheme,
        onLanguageChanged: _updateLanguage,
      ),
    );
  }
}
