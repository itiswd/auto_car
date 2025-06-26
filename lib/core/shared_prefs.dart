import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> isIntroSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seen_intro') ?? false;
  }

  static Future<void> setIntroSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_intro', true);
  }
}
