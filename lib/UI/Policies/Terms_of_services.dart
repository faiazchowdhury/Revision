import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Terms_of_services extends StatefulWidget {
  @override
  _Terms_of_servicesState createState() => _Terms_of_servicesState();
}

class _Terms_of_servicesState extends State<Terms_of_services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          "Terms of Services",
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
