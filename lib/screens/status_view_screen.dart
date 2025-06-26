import 'package:flutter/material.dart';

class StatusViewScreen extends StatelessWidget {
  const StatusViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(title: Text("Connection Status"), subtitle: Text("Connected")),
        ListTile(title: Text("Device Name"), subtitle: Text("ESP32-Car")),
        ListTile(title: Text("RSSI"), subtitle: Text("-55 dBm")),
        ListTile(title: Text("Distance"), subtitle: Text("3 meters")),
        ListTile(title: Text("Last Speed"), subtitle: Text("45 km/h")),
      ],
    );
  }
}
