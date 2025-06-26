import 'package:flutter/material.dart';

import '../core/shared_prefs.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  void _completeIntro(BuildContext context) async {
    await SharedPrefs.setIntroSeen();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(Icons.directions_car, size: 100, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Smart Car Controller!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Control your car wirelessly with ease using our app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _completeIntro(context),
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Let's Start"),
            ),
          ],
        ),
      ),
    );
  }
}
