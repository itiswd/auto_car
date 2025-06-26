import 'package:flutter/material.dart';

class WifiScannerScreen extends StatelessWidget {
  const WifiScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.wifi, size: 80, color: Colors.indigo),
          SizedBox(height: 20),
          Text(
            'Tap the search button to connect to your car device.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
