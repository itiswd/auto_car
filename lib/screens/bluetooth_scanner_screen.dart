import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../core/shared_prefs.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  BluetoothDevice? _connectedDevice;

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  void _checkBluetoothState() {
    FlutterBluePlus.adapterState.listen((state) {
      if (state != BluetoothAdapterState.on) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please turn on Bluetooth"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _startScan() async {
    final adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState != BluetoothAdapterState.on) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please turn on Bluetooth first")),
      );
      return;
    }

    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 6),
      androidUsesFineLocation: true,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Scanning for devices...")));
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      if (_connectedDevice != null &&
          _connectedDevice!.remoteId == device.remoteId) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Already connected to this device")),
        );
        return;
      }

      await device.connect();
      setState(() => _connectedDevice = device);

      await SharedPrefs.saveCurrentDevice(
        device.platformName,
        device.remoteId.str,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connected to ${device.platformName}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Connection failed: $e")));
    }
  }

  Widget _buildDeviceTile(ScanResult result) {
    final device = result.device;
    final name =
        device.platformName.isNotEmpty ? device.platformName : 'Unknown';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.bluetooth, color: Colors.indigo),
        title: Text(name),
        subtitle: Text(device.remoteId.str),
        trailing: ElevatedButton(
          onPressed: () => _connectToDevice(device),
          child: const Text('Connect'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Devices")),
      body: StreamBuilder<List<ScanResult>>(
        stream: FlutterBluePlus.scanResults,
        builder: (context, snapshot) {
          final devices = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.only(top: 12),
            children: [
              if (_connectedDevice != null)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    color: Colors.green[100],
                    child: ListTile(
                      title: const Text("Connected To"),
                      subtitle: Text(_connectedDevice!.platformName),
                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () async {
                          await _connectedDevice?.disconnect();
                          setState(() => _connectedDevice = null);
                          await SharedPrefs.clearCurrentDevice();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Disconnected")),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ...devices.map(_buildDeviceTile),
              const SizedBox(height: 100),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startScan,
        label: const Text("Scan"),
        icon: const Icon(Icons.search),
      ),
    );
  }
}
