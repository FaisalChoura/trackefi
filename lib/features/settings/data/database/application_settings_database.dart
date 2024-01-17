import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationSettingsDatabase {
  late SharedPreferences sharedPrefrences;
  ApplicationSettingsDatabase() {
    _setupPrefrences();
  }

  bool isNewUser() {
    return sharedPrefrences.getBool(ApplicationSettingsKeys.newUser) ?? true;
  }

  void setExistingUser() async {
    await sharedPrefrences.setBool(ApplicationSettingsKeys.newUser, false);
  }

  void _setupPrefrences() async {
    sharedPrefrences = await SharedPreferences.getInstance();
  }
}

class ApplicationSettingsKeys {
  static String newUser = 'newUser';
}

final applicationSettingsDatabaseProvider =
    Provider((ref) => ApplicationSettingsDatabase());
