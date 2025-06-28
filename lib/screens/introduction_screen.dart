import 'package:auto_car/screens/bluetooth_scanner_screen.dart';
import 'package:flutter/material.dart';

import '../core/shared_prefs.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  void _completeIntro(BuildContext context) async {
    await SharedPrefs.setIntroSeen();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BluetoothScannerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(Icons.directions_car, size: 160, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text(
                'Welcome to\nSmart Car Controller!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Control your car wirelessly\nwith ease using our app.',
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
      ),
    );
  }
}
