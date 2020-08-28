import 'package:http/http.dart' as http;

class NetworkUtils{
  static isResponseSuccess(http.Response response){
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 300){
      return true;
    }else{
      return false;
    }
  }
}