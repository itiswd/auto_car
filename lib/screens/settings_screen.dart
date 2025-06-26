import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SwitchListTile(
          title: Text("Dark Mode"),
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: (value) {
            // handle dark mode switch
          },
        ),
        ListTile(
          title: Text("Language"),
          subtitle: Text("English / Arabic"),
          onTap: () {
            // change language
          },
        ),
      ],
    );
  }
}
