import 'package:flutter/material.dart';

class textFieldHeaderOfRegistration extends StatelessWidget {
  String text;
  textFieldHeaderOfRegistration(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(55, 10, 55, 5),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
      ),
    );
  }
}
