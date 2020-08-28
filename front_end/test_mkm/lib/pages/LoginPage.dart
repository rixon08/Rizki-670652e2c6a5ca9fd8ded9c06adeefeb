import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_mkm/main.dart';
import 'package:test_mkm/pages/HomePage.dart';
import 'package:test_mkm/pages/RegisterPage.dart';
import 'package:test_mkm/pages/view/LoginView.dart';
import 'package:test_mkm/presenter/LoginPresenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginView {
  bool _hiddenPassword = true;

  LoginPresenter _loginPresenter;

  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginPresenter = new LoginPresenter();
    _loginPresenter.attachView(this);
    _loginPresenter.checkAlreadyLogin();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerUsername.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  void _setVisibiltyPassword() {
    setState(() {
      this._hiddenPassword = !_hiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200].withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                      )
                    ]),
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 500),
                          margin: EdgeInsets.only(top: 10.0),
                          child: textField("Username"),
                        ),
                        Container(
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 500),
                          margin: EdgeInsets.only(top: 10.0),
                          child: textField("Password"),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 80.0),
                            child: ButtonTheme(
                                minWidth: 500.0,
                                child: RaisedButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if (myControllerUsername.text != "" &&
                                          myControllerPassword.text != "") {
                                        _loginPresenter.login(
                                            myControllerUsername.text,
                                            myControllerPassword.text);
                                      } else {
                                        _showDialog(
                                            "Username and password cannot be empty");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                          left: 10.0,
                                          right: 10.0),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(40.0))))),
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: ButtonTheme(
                                minWidth: 500.0,
                                child: RaisedButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 20.0,
                                          bottom: 20.0,
                                          left: 10.0,
                                          right: 10.0),
                                      child: Text(
                                        "REGISTER",
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(40.0))))),
                      ],
                    )))),
      ),
    );
  }

  Widget textField(String label) {
    return TextField(
      controller:
          label == "Username" ? myControllerUsername : myControllerPassword,
      keyboardType: label == "Username" ? TextInputType.emailAddress : null,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        prefixIcon: Icon(label == "Password" ? Icons.lock : Icons.mail),
        suffixIcon: label == "Password"
            ? IconButton(
                icon: Icon(
                    _hiddenPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: _setVisibiltyPassword)
            : null,
      ),
      obscureText: label == "Password" && _hiddenPassword ? true : false,
    );
  }

  void _showDialog(String isi) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Warning"),
          content: new Text(isi),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onError(String error) {
    _showDialog(error);
  }

  @override
  void onSuccess(String username) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  void onStillLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
