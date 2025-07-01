import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusViewScreen extends StatefulWidget {
  const StatusViewScreen({super.key});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  String? _currentDeviceName;
  String? _currentDeviceAddress;
  String? _lastDeviceName;
  String? _lastDeviceAddress;
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
      _currentDeviceName = prefs.getString('current_device_name');
      _currentDeviceAddress = prefs.getString('current_device_address');
      _lastDeviceName = prefs.getString('last_device_name');
      _lastDeviceAddress = prefs.getString('last_device_address');
      _lastCommand = prefs.getString('last_command');
      _isConnected = prefs.getBool('is_connected') ?? false;
    });
  }

  Widget _statusCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Status View")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _statusCard(
              "Current Connected Device",
              _isConnected
                  ? (_currentDeviceName ?? "Unknown")
                  : "Not Connected",
              Icons.bluetooth_connected,
              Colors.indigo,
            ),
            _statusCard(
              "Current Device Address",
              _isConnected ? (_currentDeviceAddress ?? "-") : "-",
              Icons.qr_code_2,
              Colors.grey,
            ),
            _statusCard(
              "Last Connected Device",
              _lastDeviceName ?? "None",
              Icons.history,
              Colors.teal,
            ),
            _statusCard(
              "Last Device Address",
              _lastDeviceAddress ?? "-",
              Icons.devices_other,
              Colors.grey,
            ),
            _statusCard(
              "Connection Status",
              _isConnected ? "Connected ✅" : "Disconnected ❌",
              _isConnected ? Icons.check_circle : Icons.cancel,
              _isConnected ? Colors.green : Colors.red,
            ),
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
}
