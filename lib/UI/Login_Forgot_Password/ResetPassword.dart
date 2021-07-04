import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/bloc/Bloc/loginforgotreset_bloc.dart';

class ResetPassword extends StatefulWidget {
  String email;

  ResetPassword(String string) {
    email = string;
  }

  ResetPasswordState createState() {
    return new ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  final secretCodeController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  String email;
  bool cont = true, cont2 = true, cont3 = true, state = true;
  int stateCode = 0;
  final bloc = new LoginforgotresetBloc();

  @override
  void dispose() {
    bloc.close();
    secretCodeController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //back button on the app bar
      appBar: appBarRegistration.appBar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.topCenter,
              child: Column(children: [
                //image of the page
                Container(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset("assets/Group 232.svg"),
                          Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: SvgPicture.asset("assets/forgot.svg")),
                        ],
                      ),
                    )),

                //first text on the page
                headerTextFieldForRegistration("Reset Password"),

                //second text on the page
                secondHeaderForRegistration(
                    "Please type your reset code which has been\nsent in your email & reset password",
                    false),

                //Textfield for email
                textFieldHeaderOfRegistration("Secret Code"),
                Container(
                    height: 53,
                    padding: EdgeInsets.fromLTRB(55, 5, 55, 5),
                    child: Material(
                      elevation: 2,
                      shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                      child: TextField(
                        controller: secretCodeController,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            errorText:
                                cont ? null : "Field can't be left empty",
                            filled: true,
                            fillColor: Color.fromRGBO(247, 247, 247, 1),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(117, 117, 117, 0.7),
                                )),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(117, 117, 117, 0.1),
                                )),
                            hintText: "Secret Code",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(32, 32, 32, 0.5))),
                      ),
                    )),

                textFieldHeaderOfRegistration("New Password"),
                Container(
                    height: 53,
                    padding: EdgeInsets.fromLTRB(55, 5, 55, 5),
                    child: Material(
                      elevation: 2,
                      shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                      child: TextField(
                        obscureText: true,
                        controller: passController,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            errorText:
                                cont2 ? null : "Field can't be left empty",
                            filled: true,
                            fillColor: Color.fromRGBO(247, 247, 247, 1),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(117, 117, 117, 0.7),
                                )),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(117, 117, 117, 0.1),
                                )),
                            hintText: "New Password",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(32, 32, 32, 0.5))),
                      ),
                    )),

                textFieldHeaderOfRegistration("Confirm Password"),
                Container(
                    height: 53,
                    padding: EdgeInsets.fromLTRB(55, 5, 55, 5),
                    child: Material(
                      elevation: 2,
                      shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                      child: TextField(
                        obscureText: true,
                        controller: confirmPassController,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            errorText:
                                cont3 ? null : "Field can't be left empty",
                            filled: true,
                            fillColor: Color.fromRGBO(247, 247, 247, 1),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(117, 117, 117, 0.7),
                                )),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(117, 117, 117, 0.1),
                                )),
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(32, 32, 32, 0.5))),
                      ),
                    )),

                Visibility(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_rounded,
                          color: Colors.red,
                          size: 15,
                        ),
                        Text(
                          stateCode >= 500
                              ? "Server Error"
                              : "Passwords don't match!",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  visible: stateCode >= 400,
                ),
                //button to continue
                Visibility(
                    visible: state,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      alignment: Alignment.center,
                      child: Material(
                          elevation: 3,
                          shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Color.fromRGBO(139, 187, 46, 1),
                          child: FlatButton(
                            height: 40,
                            minWidth: 295,
                            color: Color.fromRGBO(139, 187, 46, 1),
                            textColor: Colors.white,
                            child: Text(
                              "Submit",
                            ),
                            onPressed: () async {
                              if (secretCodeController.text == "") {
                                setState(() {
                                  cont = false;
                                });
                              } else {
                                if (passController.text == "") {
                                  setState(() {
                                    cont2 = false;
                                  });
                                } else {
                                  if (confirmPassController.text == "") {
                                    setState(() {
                                      cont3 = false;
                                    });
                                  } else {
                                    if (confirmPassController.text !=
                                        passController.text) {
                                      setState(() {
                                        stateCode = 450;
                                      });
                                    } else {
                                      setState(() {
                                        state = false;
                                      });
                                    }
                                  }
                                }
                              }
                            },
                          )),
                    )),
                Visibility(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator()),
                  visible: !state,
                )
              ]))),
    );
  }
}
