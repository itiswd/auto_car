import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bluetooth_provider.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  Widget _glassCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bluetooth = Provider.of<BluetoothProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Bluetooth Devices"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 100, bottom: 100),
          children: [
            if (bluetooth.connectedDevice != null)
              _glassCard(
                child: ListTile(
                  leading: const Icon(
                    Icons.bluetooth_connected,
                    color: Colors.green,
                  ),
                  title: const Text(
                    "Connected To",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    bluetooth.connectedDevice!.name ?? "Unknown",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.redAccent),
                    onPressed: bluetooth.disconnect,
                  ),
                ),
              ),
            ...bluetooth.devices.map((result) {
              final device = result.device;
              final name = device.name ?? "Unknown";
              return _glassCard(
                child: ListTile(
                  leading: const Icon(Icons.bluetooth, color: Colors.white),
                  title: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    device.address,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => bluetooth.connectToDevice(device),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Connect"),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: bluetooth.isScanning ? null : bluetooth.startScan,
        backgroundColor:
            bluetooth.isScanning ? Colors.grey.shade800 : Colors.tealAccent,
        foregroundColor: bluetooth.isScanning ? Colors.white : Colors.black,
        icon: const Icon(Icons.wifi_tethering),
        label: Text(
          bluetooth.isScanning ? "Scanning..." : "Start Scan",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
