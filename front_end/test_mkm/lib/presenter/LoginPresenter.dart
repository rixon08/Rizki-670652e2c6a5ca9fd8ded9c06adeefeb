import 'dart:convert';

import 'package:test_mkm/data/AppDataManager.dart';
import 'package:test_mkm/models/LoginResponseModel.dart';
import 'package:test_mkm/network/NetworkUtils.dart';
import 'package:test_mkm/pages/view/LoginView.dart';
import 'package:test_mkm/presenter/BasePresenter.dart';

class LoginPresenter extends BasePresenter<LoginView>{
  Future login(String username, String password) async {
    var response = await appDataManager.apiHelper.getResponseLogin(username, password, DateTime.now().toUtc().millisecondsSinceEpoch);
    
    if(NetworkUtils.isResponseSuccess(response))
      await parseLogin(response.body);
    else
      getView() != null ? getView().onError("Cannot get data") : null;

  }

  parseLogin(String responseBody) async {
    
    Map tagObjsJson = jsonDecode(responseBody);
    var loginM = LoginModel.fromJson(tagObjsJson);
    if(loginM.status_code == 200 && loginM.message == "success"){ 
      await appDataManager.sharedPreferencesData.setUsernameToSF(loginM.username);     
      getView() != null ? getView().onSuccess(loginM.username) : null;
    }else{
      getView() != null ? getView().onError(loginM.message) : null;
    }
  }

  


  Future checkAlreadyLogin() async {
    var username = await appDataManager.sharedPreferencesData.getUsernameFromSF();
    if(username != '' ){
      getView() != null ? getView().onStillLogin() : null;
    }
  }
}