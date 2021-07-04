import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class snackbar {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final String _text;
  snackbar(this._scaffoldKey, this._text);

  showSnackbar() {
    return _scaffoldKey.currentState.showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromRGBO(101, 101, 101, 1)),
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        )));
  }
}
