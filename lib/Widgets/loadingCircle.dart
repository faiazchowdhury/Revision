import 'package:flutter/material.dart';

class loadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    );
  }
}
