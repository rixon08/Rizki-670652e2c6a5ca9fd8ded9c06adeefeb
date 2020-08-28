import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  setUsernameToSF(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  getUsernameFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    return stringValue ?? "";
  }

  
}
