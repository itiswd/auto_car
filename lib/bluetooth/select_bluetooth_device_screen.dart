// lib/screens/select_bluetooth_device_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SelectBluetoothDeviceScreen extends StatelessWidget {
  const SelectBluetoothDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Bluetooth Device")),
      body: FutureBuilder<List<BluetoothDevice>>(
        future: FlutterBluetoothSerial.instance.getBondedDevices(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final devices = snapshot.data!;
          if (devices.isEmpty) {
            return const Center(child: Text("No paired devices found"));
          }

          return ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return ListTile(
                leading: const Icon(Icons.bluetooth),
                title: Text(device.name ?? "Unknown"),
                subtitle: Text(device.address),
                onTap: () {
                  Navigator.pop(context, device);
                },
              );
            },
          );
        },
      ),
    );
  }
}
