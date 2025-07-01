import 'package:permission_handler/permission_handler.dart';

/// 🛡️ Request all needed Bluetooth permissions
Future<void> requestBluetoothPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.location,
  ].request();
}
