import 'package:shared_preferences/shared_preferences.dart';

class SimpleLocalSave {
  static late SharedPreferences preferences;
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static Future setDate(DateTime date) async {
    final birthday = date.toIso8601String();
    await preferences.setString("date", birthday);
  }

  static DateTime? getDate() {
    final birthday = preferences.getString("date");
    if (birthday == null) return null;
    return DateTime.tryParse(birthday);
  }
}
