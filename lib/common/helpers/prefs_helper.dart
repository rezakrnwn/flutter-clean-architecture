import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static const keyIsLoggedIn = "is_logged_in";
  static const keyUsername = "username";

  final SharedPreferences preferences;

  PrefsHelper({
    required this.preferences,
  });

  bool isLoggedIn() => preferences.getBool(keyIsLoggedIn) ?? false;

  Future<bool> setIsLoggedIn(bool value) async =>
      await preferences.setBool(keyIsLoggedIn, value);

  String getUsername() => preferences.getString(keyUsername) ?? "No name";

  Future<bool> setUsername(String value) async =>
      await preferences.setString(keyUsername, value);
}
