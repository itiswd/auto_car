import 'package:flutter/material.dart';

class StatusViewScreen extends StatelessWidget {
  const StatusViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder values
    const connected = true;
    const deviceName = 'CarESP';
    const rssi = -60;
    const distance = '5m';
    const lastSpeed = '40 km/h';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Connected: $connected'),
          Text('Device: $deviceName'),
          Text('RSSI: $rssi dBm'),
          Text('Distance: $distance'),
          Text('Last Speed: $lastSpeed'),
        ],
      ),
    );
  }
}
