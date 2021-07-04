import 'package:flutter/cupertino.dart';

class secondHeaderForRegistration extends StatelessWidget {
  String text;
  bool flag;
  secondHeaderForRegistration(this.text, this.flag);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            color:flag
                ? Color.fromRGBO(249, 175, 25, 1)
                : Color.fromRGBO(31, 49, 75, 0.45)),
      ),
    );
  }
}
