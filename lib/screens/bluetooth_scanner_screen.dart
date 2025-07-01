import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen>
    with TickerProviderStateMixin {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice? _connectedDevice;
  bool _isScanning = false;
  final List<BluetoothDiscoveryResult> _devicesList = [];

  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState != BluetoothState.STATE_ON) {
      await FlutterBluetoothSerial.instance.requestEnable();
    }

    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      setState(() => _bluetoothState = state);
    });

    // _startScan();
  }

  void _startScan() {
    _devicesList.clear();
    setState(() => _isScanning = true);

    FlutterBluetoothSerial.instance
        .startDiscovery()
        .listen((r) {
          final existingIndex = _devicesList.indexWhere(
            (element) => element.device.address == r.device.address,
          );
          if (existingIndex >= 0) {
            _devicesList[existingIndex] = r;
          } else {
            _devicesList.add(r);
          }

          setState(() {});
        })
        .onDone(() {
          setState(() => _isScanning = false);
          _fadeController.forward(from: 0);
        });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      // final connection = await BluetoothConnection.toAddress(device.address);
      setState(() => _connectedDevice = device);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("last_device_name", device.name ?? "Unknown");
      await prefs.setString("last_device_address", device.address);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Connected to ${device.name}")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Connection failed: $e")));
    }
  }

  Future<void> _disconnect() async {
    setState(() => _connectedDevice = null);
  }

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
            if (_connectedDevice != null)
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
                    _connectedDevice!.name ?? "Unknown",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.redAccent),
                    onPressed: _disconnect,
                  ),
                ),
              ),
            ..._devicesList.map((result) {
              final device = result.device;
              final name = device.name ?? "Unknown";

              return FadeTransition(
                opacity: _fadeController,
                child: _glassCard(
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
                      onPressed: () => _connectToDevice(device),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Connect"),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isScanning ? null : _startScan,
        backgroundColor: _isScanning ? Colors.grey.shade800 : Colors.tealAccent,
        foregroundColor: _isScanning ? Colors.white : Colors.black,
        icon: const Icon(Icons.wifi_tethering),
        label: Text(
          _isScanning ? "Scanning..." : "Start Scan",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
