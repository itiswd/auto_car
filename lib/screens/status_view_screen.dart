import 'package:flutter/material.dart';

class StatusViewScreen extends StatelessWidget {
  const StatusViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Connection Status',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: const Text('Connected'),
            subtitle: const Text('Device: CarESP'),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.network_wifi),
            title: const Text('RSSI: -60 dBm'),
            subtitle: const Text('Distance: ~5m'),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Last Recorded Speed'),
            subtitle: const Text('40 km/h'),
          ),
        ),
      ],
    );
  }
}
