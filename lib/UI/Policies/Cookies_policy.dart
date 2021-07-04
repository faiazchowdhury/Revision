import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cookies_policy extends StatefulWidget {
  @override
  _Cookies_policyState createState() => _Cookies_policyState();
}

class _Cookies_policyState extends State<Cookies_policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          "Cookies Policy",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        backgroundColor: Color.fromRGBO(13, 106, 106, 1),
        elevation: 5,
      ),
      body: Container(),
    );
  }
}
