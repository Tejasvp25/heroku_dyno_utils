import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String API_KEY = "API_KEY";

  static Future<String> getApikey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(API_KEY) ?? "";
  }

  static Future<void> setApiKey(String apiKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(API_KEY, apiKey);
  }
}
