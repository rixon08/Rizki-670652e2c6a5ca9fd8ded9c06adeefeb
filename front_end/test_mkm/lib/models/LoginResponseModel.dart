class LoginModel{
  int status_code;
  String message;
  String username;
  String login_time;
  String login_state;

  LoginModel({this.status_code, this.message, this.username,this.login_time,  this.login_state});

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      status_code: json['status_code'],
      message: json['message'],
      username: json['username'] ?? "",
      login_time: json['login_time'] ?? "",
      login_state: json['login_state'] ?? "",
    );
      
  }
}