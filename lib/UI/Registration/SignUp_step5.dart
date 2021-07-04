import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:quick_assist/textfield1.dart';
//import 'package:quick_assist/registration_storage.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/profilePictureUpload.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Model/profilePicture.dart';
import 'package:revised_quickassist/bloc/Bloc/registrationmethods_bloc.dart';
import 'SignUp_step6.dart';

class SignUp_step5 extends StatefulWidget {
  _SignUp_step5_state createState() {
    return new _SignUp_step5_state();
  }
}

class _SignUp_step5_state extends State<SignUp_step5> {
  bool cont = true;
  double width;
  double newheight;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    newheight = height - padding.top - padding.bottom;
    return Scaffold(
        //back button on the app bar
        appBar: appBarRegistration.appBar(context),
        backgroundColor: Colors.white,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: newheight,
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset("assets/Group 232.svg"),
                        Container(
                            padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
                            child: SvgPicture.asset("assets/camera.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) + ((width / 6) * 0.5)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) - ((width / 6) * 0.8)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) + ((width / 6) * 1.8)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) + ((width / 6) * 3.1)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                      ],
                    ),
                  )),

              //first text on the page
              headerTextFieldForRegistration("Please upload your Photo"),

              //second text on the page
              secondHeaderForRegistration(
                  "Try to upload a photo where your face can be seen perfectly and wear a smile",
                  true),

              SizedBox(
                height: 20,
              ),
              Container(
                width: cont ? 0 : width,
                height: cont ? 0 : 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 12,
                    ),
                    Text(
                      "Need to upload a picture of your face!",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              profilePictureUpload(),
              Container(
                padding: EdgeInsets.fromLTRB(55, 50, 55, 30),
                alignment: Alignment.bottomCenter,
                child: Material(
                    elevation: 3,
                    shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Color.fromRGBO(139, 187, 46, 1),
                    child: FlatButton(
                      height: 40,
                      minWidth: width,
                      color: Color.fromRGBO(139, 187, 46, 1),
                      textColor: Colors.white,
                      child: Text(
                        "Continue",
                      ),
                      onPressed: () {
                        if (profilePicture.getImg == null) {
                          setState(() {
                            cont = false;
                          });
                        } else {
                          setState(() {
                            cont = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp_step6()));
                          });
                        }
                      },
                    )),
              )
            ]))));
  }
}
