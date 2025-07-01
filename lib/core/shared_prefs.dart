import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> isIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seen_intro') ?? false;
  }

  static Future<void> setIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);
  }

  static Future<void> saveCurrentDevice(String name, String address) async {
    final prefs = await SharedPreferences.getInstance();

    // احتفظ بالقديم كـ "آخر جهاز"
    final oldName = prefs.getString('current_device_name');
    final oldAddress = prefs.getString('current_device_address');
    if (oldName != null && oldAddress != null) {
      await prefs.setString('last_device_name', oldName);
      await prefs.setString('last_device_address', oldAddress);
    }

    // سجّل الجديد
    await prefs.setString('current_device_name', name);
    await prefs.setString('current_device_address', address);
    await prefs.setBool('is_connected', true);
  }

  static Future<void> clearCurrentDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_connected', false);
    await prefs.remove('current_device_name');
    await prefs.remove('current_device_address');
  }

  static Future<void> saveLastCommand(String command) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_command', command);
  }
}
