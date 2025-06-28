// lib/bluetooth/bluetooth_helper.dart
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothHelper {
  BluetoothConnection? _connection;
  Function(bool)? onConnectionChanged;

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      _connection!.input!.listen(null).onDone(() {
        onConnectionChanged?.call(false);
      });
      onConnectionChanged?.call(true);
      return true;
    } catch (_) {
      onConnectionChanged?.call(false);
      return false;
    }
  }

  void sendCommand(String command) {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(Uint8List.fromList(('$command\n').codeUnits));
    }
  }

  void dispose() {
    _connection?.dispose();
  }

  bool get isConnected => _connection?.isConnected ?? false;
}
