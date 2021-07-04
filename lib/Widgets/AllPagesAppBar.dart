import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/UI/AllPages/Notifications.dart';

class AllPagesAppBar {
  static Widget appBar(
      BuildContext context, bool backButton, bool notification, String text) {
    return AppBar(
      centerTitle: true,
      leading: backButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : Container(),
      actions: [
        Visibility(
          visible: notification,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notifications()));
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(20),
              child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset("assets/notification.svg")),
            ),
          ),
        )
      ],
      title: Text(text),
      backgroundColor: Color.fromRGBO(13, 106, 106, 1),
      elevation: 0,
    );
  }
}
