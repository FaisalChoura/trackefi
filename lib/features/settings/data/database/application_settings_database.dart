import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationSettingsDatabase {
  final SharedPreferences _sharedPrefrences;
  ApplicationSettingsDatabase(this._sharedPrefrences);

  bool isNewUser() {
    return _sharedPrefrences.getBool(ApplicationSettingsKeys.newUser) ?? true;
  }

  void setExistingUser() async {
    await _sharedPrefrences.setBool(ApplicationSettingsKeys.newUser, false);
  }
}

class ApplicationSettingsKeys {
  static String newUser = 'newUser';
}

final applicationSettingsDatabaseProvider = Provider((ref) async =>
    ApplicationSettingsDatabase(await SharedPreferences.getInstance()));
