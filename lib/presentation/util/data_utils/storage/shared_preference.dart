// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSourceImpl implements LocalDataSource {
  late SharedPreferences sharedPreferences;
  LocalDataSourceImpl(this.sharedPreferences);

  @override
  void setData({required String name, dynamic data}) {
    sharedPreferences.setString(name, data);
  }

  @override
  String? getData({required String name}) {
    final String? data = sharedPreferences.getString(name);
    return data;
  }

  @override
  void setBoolData({required String name, required bool data}) {
    sharedPreferences.setBool(name, data);
  }

  @override
  bool? getBoolData({required String name}) {
    final bool? data = sharedPreferences.getBool(name);
    return data;
  }

  @override
  void removeData({required String name}) {
    sharedPreferences.remove(name);
  }

  @override
  void clearAll() {
    var pass = sharedPreferences.getString("passcode");
    sharedPreferences.clear();
    sharedPreferences.setBool("isFirstLaunch", false);
    if (pass != null) sharedPreferences.setString("passcode", pass);
  }

  static const THEME_STATUS = "THEMESTATUS";

  @override
  setDarkTheme({required bool value}) async {
    sharedPreferences.setBool(THEME_STATUS, value);
  }

  @override
  bool? getTheme() {
    return sharedPreferences.getBool(THEME_STATUS) ?? false;
  }
}

abstract class LocalDataSource {
  void setData({required String name, data}) {}

  String? getData({required String name}) {
    return null;
  }

  void setBoolData({required String name, required bool data}) {}
  bool? getBoolData({required String name}) {
    return null;
  }

  void removeData({required String name}) {}
  void clearAll() {}
  void setDarkTheme({required bool value}) {}
  bool? getTheme() {
    return null;
  }
}
