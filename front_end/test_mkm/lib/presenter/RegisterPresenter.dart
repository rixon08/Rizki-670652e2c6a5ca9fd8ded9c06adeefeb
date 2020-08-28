import 'dart:convert';

import 'package:test_mkm/data/AppDataManager.dart';
import 'package:test_mkm/models/RegisterResponseModel.dart';
import 'package:test_mkm/network/NetworkUtils.dart';
import 'package:test_mkm/pages/view/RegisterView.dart';
import 'package:test_mkm/presenter/BasePresenter.dart';

class RegisterPresenter extends BasePresenter<RegisterView> {
  Future register(String username, String password) async {
    var response = await appDataManager.apiHelper.getResponseRegister(username, password);
    

    // Use the compute function to run parsePhotos in a separate isolate.
    if(NetworkUtils.isResponseSuccess(response))
      parseRegister(response.body);
    else
      getView() != null ? getView().onError("Cannot get data") : null;

  }

  parseRegister(String responseBody) {
    Map tagObjsJson = jsonDecode(responseBody);
    var _registerResponse = RegisterResponseModel.fromJson(tagObjsJson);
    if(_registerResponse.statusCode == 200 && _registerResponse.message == "success"){
      getView() != null ? getView().onSuccess() : null;
    }else{
      getView() != null ? getView().onError(_registerResponse.message) : null;
    }

    
  }
}