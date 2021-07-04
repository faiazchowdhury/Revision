import 'package:flutter/material.dart';

class appBarRegistration {
  static Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Color.fromRGBO(13, 106, 106, 1),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
