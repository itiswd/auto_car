import 'package:auto_car/bluetooth/select_bluetooth_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../bluetooth/bluetooth_helper.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen> {
  double _speed = 0;
  final BluetoothHelper _bluetooth = BluetoothHelper();
  bool _connected = false;
  BluetoothDevice? _selectedDevice;

  @override
  void initState() {
    super.initState();

    _bluetooth.onConnectionChanged = (connected) {
      setState(() => _connected = connected);
      if (!connected) _showDisconnectedDialog();
    };
  }

  Future<void> _selectAndConnectDevice() async {
    final device = await Navigator.push<BluetoothDevice>(
      context,
      MaterialPageRoute(builder: (_) => const SelectBluetoothDeviceScreen()),
    );

    if (device != null) {
      setState(() => _selectedDevice = device);
      await _bluetooth.connectToDevice(device);
    }
  }

  void _sendSpeedToCar() {
    if (_connected) {
      _bluetooth.sendCommand("SPEED=${_speed.toInt()}");
    }
  }

  void _showDisconnectedDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Disconnected'),
            content: const Text('Bluetooth connection was lost.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _bluetooth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Control'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bluetooth_searching),
            onPressed: _selectAndConnectDevice,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _connected
                      ? Icons.bluetooth_connected
                      : Icons.bluetooth_disabled,
                  color: _connected ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  _connected
                      ? 'Connected to ${_selectedDevice?.name ?? "Device"}'
                      : 'Not connected',
                  style: TextStyle(
                    color: _connected ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Set Car Speed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              '${_speed.toInt()} km/h',
              style: const TextStyle(fontSize: 32, color: Colors.indigo),
            ),
            Slider(
              value: _speed,
              min: 0,
              max: 100,
              divisions: 20,
              label: '${_speed.toInt()} km/h',
              onChanged: (value) {
                setState(() => _speed = value);
                _sendSpeedToCar();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => _speed = 0);
                _sendSpeedToCar();
              },
              icon: const Icon(Icons.stop),
              label: const Text('Stop'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
