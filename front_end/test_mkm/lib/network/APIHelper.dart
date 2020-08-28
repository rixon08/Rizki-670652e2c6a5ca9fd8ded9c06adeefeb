import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class APIHelper {
  final String url = "http://192.168.43.171/api/v1/Users/";
  Future getResponseLogin(
    String username,
    String password,
    int loginTime
  ) async {
    var response = await http.post(
      url + "login/",
      body: {
        'username': username,
        'password': password,
        'loginTime': "121212",
      },
    );
    return response;
  }

  Future getResponseRegister(
    String username,
    String password
  ) async {
    var response = await http.post(
      url + "register/",
      body: {
        'username': username,
        'password': password,
      },
    );
    return response;
  }
}
