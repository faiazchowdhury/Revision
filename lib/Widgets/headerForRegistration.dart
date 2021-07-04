import 'package:flutter/cupertino.dart';

class headerTextFieldForRegistration extends StatelessWidget {
  String text;
  headerTextFieldForRegistration(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color.fromRGBO(32, 32, 32, 1)),
      ),
    );
  }
}
