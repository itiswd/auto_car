import 'package:flutter/material.dart';

class WifiScannerScreen extends StatelessWidget {
  const WifiScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wifi Scanner")),
      body: Center(child: Text("Scan and connect to your car device here.")),
    );
  }
}
