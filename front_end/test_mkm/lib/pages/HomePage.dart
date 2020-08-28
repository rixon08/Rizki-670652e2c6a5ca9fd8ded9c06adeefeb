import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _timeString = "";

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Container(
            child: Column(
          children: [
            Text(_timeString ?? "", style: TextStyle(fontSize: 20.0)),
            Container(
                margin: EdgeInsets.only(top: 80.0),
                child: ButtonTheme(
                    minWidth: 500.0,
                    child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                          child: Text(
                            "HALLO",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(40.0))))),
          ],
        )),
      ),
    ));
  }


  void _showDialog(String isi, String username, String logintime) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Pesan"),
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
}
