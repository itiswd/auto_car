import 'package:auto_car/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

import 'core/shared_prefs.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hasSeenIntro = await SharedPrefs.isIntroSeen();

  runApp(MyApp(hasSeenIntro: hasSeenIntro));
}

class MyApp extends StatelessWidget {
  final bool hasSeenIntro;

  const MyApp({super.key, required this.hasSeenIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Car Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: hasSeenIntro ? const HomeScreen() : const IntroScreen(),
    );
  }
}
