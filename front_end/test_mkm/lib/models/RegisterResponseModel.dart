class RegisterResponseModel {
  int statusCode;
  String message;

  RegisterResponseModel({this.statusCode, this.message});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json){
    return RegisterResponseModel(
      statusCode: json['status_code'],
      message: json['message'],
    );
      
  }

}