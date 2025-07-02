import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../core/shared_prefs.dart';

class BluetoothService {
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;

  BluetoothService._internal();

  BluetoothConnection? _connection;

  Future<void> connect() async {
    if (_connection != null && _connection!.isConnected) return;

    final address = await SharedPrefs.getCurrentDeviceAddress();
    if (address != null) {
      _connection = await BluetoothConnection.toAddress(address);
    }
  }

  Future<void> send(String data) async {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(Uint8List.fromList(data.codeUnits));
      await SharedPrefs.saveLastCommand(data);
    } else {
      throw Exception("Not connected");
    }
  }

  bool get isConnected => _connection?.isConnected ?? false;
}
