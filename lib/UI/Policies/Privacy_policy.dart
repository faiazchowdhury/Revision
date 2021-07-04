import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy_policy extends StatefulWidget {
  @override
  _Privacy_policyState createState() => _Privacy_policyState();
}

class _Privacy_policyState extends State<Privacy_policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          "Privacy Policy",
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
