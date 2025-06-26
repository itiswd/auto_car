import 'package:auto_car/core/shared_prefs.dart';
import 'package:auto_car/screens/home_screen.dart';
import 'package:auto_car/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool seen = await SharedPrefs.isIntroSeen();
  runApp(MyApp(seenIntro: seen));
}

class MyApp extends StatelessWidget {
  final bool seenIntro;
  const MyApp({super.key, required this.seenIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Car Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: seenIntro ? HomeScreen() : IntroductionScreen(),
    );
  }
}
