// lib/screens/status_view_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  String? _deviceName;
  String? _deviceAddress;
  String? _lastCommand;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _deviceName = prefs.getString('last_device_name');
      _deviceAddress = prefs.getString('last_device_address');
      _lastCommand = prefs.getString('last_command');
      _isConnected = prefs.getBool('is_connected') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status View')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _statusCard(
              "Device Name",
              _deviceName ?? "Not Connected",
              Icons.bluetooth,
              Colors.indigo,
            ),
            const SizedBox(height: 12),
            _statusCard(
              "Device Address",
              _deviceAddress ?? "-",
              Icons.qr_code,
              Colors.grey,
            ),
            const SizedBox(height: 12),
            _statusCard(
              "Connection Status",
              _isConnected ? "Connected ✅" : "Disconnected ❌",
              _isConnected ? Icons.check_circle : Icons.cancel,
              _isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 12),
            _statusCard(
              "Last Command Sent",
              _lastCommand ?? "None",
              Icons.send,
              Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 36, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
