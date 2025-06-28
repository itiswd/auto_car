import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  String? lastDeviceName;
  String? lastDeviceId;

  @override
  void initState() {
    super.initState();
    _loadLastDevice();
  }

  Future<void> _loadLastDevice() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastDeviceName = prefs.getString("last_device_name") ?? "Unknown";
      lastDeviceId = prefs.getString("last_device_id") ?? "N/A";
    });
  }

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
            leading: const Icon(Icons.device_hub),
            title: const Text('Last Connected Device'),
            subtitle: Text('Name: $lastDeviceName\nID: $lastDeviceId'),
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
