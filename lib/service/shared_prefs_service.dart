import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _sharedPreferenceUserLoggenInKey = 'ISLOGGEDIN';
  static const String _sharedPreferenceUidKey = 'UIDKEY';

  static Future<void> saveUserLoggedIn(String uid, bool isLogged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sharedPreferenceUidKey, uid);
    await prefs.setBool(_sharedPreferenceUserLoggenInKey, isLogged);
  }

  static Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_sharedPreferenceUserLoggenInKey) ?? false;
    // return false;
  }

  static Future<String> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sharedPreferenceUidKey) ?? '';
  }

  static Future<void> saveSignOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_sharedPreferenceUserLoggenInKey, false);
  }

  static Future<void> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
