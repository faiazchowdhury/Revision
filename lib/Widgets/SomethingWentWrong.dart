import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_rounded,
                  color: Colors.black.withOpacity(0.5),
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Something went Wrong! Please try again later!",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                ),
              ],
            )));
  }
}
