import 'package:flutter/material.dart';
import 'package:test_mkm/pages/view/RegisterView.dart';
import 'package:test_mkm/presenter/RegisterPresenter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> implements RegisterView {

  bool _hiddenPassword = true;

  RegisterPresenter _registerPresenter;

  final myControllerUsername = TextEditingController();
  final myControllerPassword = TextEditingController();
  final myControllerRepeatPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registerPresenter = new RegisterPresenter();
    _registerPresenter.attachView(this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerUsername.dispose();
    myControllerPassword.dispose();
    myControllerRepeatPassword.dispose();
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
                          constraints:
                              BoxConstraints(minWidth: 100, maxWidth: 500),
                          margin: EdgeInsets.only(top: 10.0),
                          child: textField("Repeat Password"),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: ButtonTheme(
                                minWidth: 500.0,
                                child: RaisedButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      if(myControllerUsername.text != "" && myControllerPassword.text != "" && myControllerRepeatPassword.text != ""){
                                        if(myControllerPassword.text == myControllerRepeatPassword.text){
                                          _registerPresenter.register(myControllerUsername.text, myControllerPassword.text); 
                                          
                                        }else{
                                          _showDialog("Password harus sama", true);
                                        }
                                        
                                      }else {

                                      }
                                      
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
                                            new BorderRadius.circular(40.0)))))
                      ],
                    )))),
      ),
    );
  }

  Widget textField(String label) {
    return TextField(
      controller: label == "Username" ? myControllerUsername : (label == "Password" ? myControllerPassword : myControllerRepeatPassword),
      keyboardType: label == "Username" ? TextInputType.emailAddress : null,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        prefixIcon: Icon(label == "Password" || label == "Repeat Password" ? Icons.lock : Icons.mail),
        suffixIcon: label == "Password" || label == "Repeat Password"
            ? IconButton(
                icon: Icon(
                    _hiddenPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: _setVisibiltyPassword)
            : null,
      ),
      obscureText: (label == "Password" || label == "Repeat Password") && _hiddenPassword ? true : false,
    );
  }

  void _showDialog(String isi, bool isError) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Warning"),
          content: Text(isi),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if(!isError){                  
                  closeClass();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void closeClass(){
    Navigator.of(context).pop();
  }

  @override
  void onError(String error) {
    _showDialog(error, true);
  }

  @override
  void onSuccess() {
    _showDialog("Success", false);
  }
}