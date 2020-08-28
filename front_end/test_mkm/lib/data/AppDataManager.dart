import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_mkm/data/SharedPreferencesData.dart';
import 'package:test_mkm/network/APIHelper.dart';

AppDataManager appDataManager = new AppDataManager();

class AppDataManager {
  static final AppDataManager _appDataManager = new AppDataManager._internal();
  final APIHelper apiHelper = new APIHelper();
  final SharedPreferencesData sharedPreferencesData = new SharedPreferencesData();
  factory AppDataManager() {
    return _appDataManager;
  }
  AppDataManager._internal();
}