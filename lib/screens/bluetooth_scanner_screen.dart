import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothScannerScreen extends StatefulWidget {
  const BluetoothScannerScreen({super.key});

  @override
  State<BluetoothScannerScreen> createState() => _BluetoothScannerScreenState();
}

class _BluetoothScannerScreenState extends State<BluetoothScannerScreen> {
  List<ScanResult> _scanResults = [];
  BluetoothDevice? _connectedDevice;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;
  BluetoothCharacteristic? _characteristic;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  Future<void> _startScan() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();

    _scanResults.clear();
    setState(() {});
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() => _scanResults = results);
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() => _connectedDevice = device);

      // تحديث حالة الاتصال عند تغيّرها
      device.connectionState.listen((state) {
        setState(() {
          _connectionState = state;
        });
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('✅ Connected to ${device.name}')));

      final services = await device.discoverServices();
      for (var service in services) {
        for (var char in service.characteristics) {
          if (char.properties.write) {
            _characteristic = char;
          }

          if (char.properties.notify) {
            await char.setNotifyValue(true);
            char.value.listen((value) {
              final received = utf8.decode(value);
              print("📥 Received: $received");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("📥 From device: $received")),
              );
            });
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Connection failed: $e')));
    }
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    _connectedDevice?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = _connectionState == BluetoothConnectionState.connected;

    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Devices")),
      floatingActionButton: FloatingActionButton(
        onPressed: _startScan,
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        children: [
          // عرض الحالة واسم الجهاز
          if (_connectedDevice != null)
            Container(
              width: double.infinity,
              color: isConnected ? Colors.green.shade100 : Colors.red.shade100,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    "Device: ${_connectedDevice!.name.isEmpty ? 'Unknown' : _connectedDevice!.name}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Status: ${isConnected ? '🟢 Connected' : '🔴 Disconnected'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          Expanded(
            child:
                _scanResults.isEmpty
                    ? const Center(
                      child: Text("🔍 Scanning for BLE devices..."),
                    )
                    : ListView.builder(
                      itemCount: _scanResults.length,
                      itemBuilder: (context, index) {
                        final result = _scanResults[index];
                        final device = result.device;
                        return ListTile(
                          leading: const Icon(Icons.bluetooth),
                          title: Text(
                            device.name.isNotEmpty ? device.name : "Unknown",
                          ),
                          subtitle: Text(device.id.toString()),
                          trailing: ElevatedButton(
                            onPressed: () => _connectToDevice(device),
                            child: const Text("Connect"),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
