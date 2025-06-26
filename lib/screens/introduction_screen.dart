import 'package:auto_car/core/shared_prefs.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  void completeIntro(BuildContext context) async {
    await SharedPrefs.setIntroSeen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          introPage(
            "Welcome to Smart Car Controller",
            "Control your car easily.",
          ),
          introPage(
            "Connect via WiFi",
            "Make sure your car is ready to receive signals.",
          ),
          introPage("Manual & Auto Modes", "Choose how you want to drive."),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => completeIntro(context),
        label: Text("Get Started"),
        icon: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget introPage(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              subtitle,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
