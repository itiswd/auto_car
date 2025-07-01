import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveCurrentDevice(String name, String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_device_name', name);
    await prefs.setString('current_device_address', address);
    await prefs.setBool('is_connected', true);
  }

  static Future<String?> getCurrentDeviceAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_device_address');
  }

  static Future<String?> getCurrentDeviceName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_device_name');
  }

  static Future<void> clearCurrentDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_device_name');
    await prefs.remove('current_device_address');
    await prefs.setBool('is_connected', false);
  }

  static Future<bool> isConnected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_connected') ?? false;
  }

  static Future<void> saveLastCommand(String command) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_command', command);
  }

  static Future<String?> getLastCommand() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_command');
  }
}
