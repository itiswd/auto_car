import 'package:flutter/material.dart';

import '../core/language.dart';
import '../core/shared_prefs.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged;
  final Function(String)? onLanguageChanged;

  const SettingsScreen({
    super.key,
    this.onThemeChanged,
    this.onLanguageChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String languageCode = 'en';

  @override
  void initState() {
    super.initState();
    SharedPrefs.getThemeMode().then(
      (value) => setState(() => isDarkMode = value),
    );
    SharedPrefs.getLanguageCode().then(
      (value) => setState(() => languageCode = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SwitchListTile(
          title: Text(SimpleLocalization.getText('darkMode', languageCode)),
          value: isDarkMode,
          onChanged: (value) {
            setState(() => isDarkMode = value);
            SharedPrefs.setThemeMode(value);
            widget.onThemeChanged?.call(value);
          },
        ),
        const SizedBox(height: 20),
        ListTile(
          title: Text(SimpleLocalization.getText('language', languageCode)),
          subtitle: Text(
            SimpleLocalization.getText(
              languageCode == 'en' ? 'english' : 'arabic',
              languageCode,
            ),
          ),
          onTap: () {
            String newCode = languageCode == 'en' ? 'ar' : 'en';
            setState(() => languageCode = newCode);
            SharedPrefs.setLanguageCode(newCode);
            widget.onLanguageChanged?.call(newCode);
          },
          trailing: Icon(Icons.language),
        ),
      ],
    );
  }
}
