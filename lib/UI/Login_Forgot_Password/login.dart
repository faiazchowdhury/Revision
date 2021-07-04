import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/UI/AllPages/TabSelector.dart';
import 'package:revised_quickassist/UI/Login_Forgot_Password/ForgotPassword.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/bloc/Bloc/loginforgotreset_bloc.dart';
import 'package:revised_quickassist/main.dart';

class login extends StatefulWidget {
  _loginstate createState() {
    return new _loginstate();
  }
}

class _loginstate extends State<login> {
  String error = "";
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final bloc = new LoginforgotresetBloc();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
                (route) => route == context ? true : false);
          }
        },
        child: Scaffold(
          //back button on the app bar
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(13, 106, 106, 1),
              ),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MyApp(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final begin = Offset(-1, 0);
                          final end = Offset.zero;
                          final curve = Curves.decelerate;
                          final tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                      (route) => route == context ? true : false);
                }
              },
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  //image of the page
                  Container(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/Group 232.svg",
                            ),
                            SvgPicture.asset(
                              "assets/Group 588.svg",
                            )
                          ],
                        ),
                      )),

                  //first text on the page
                  headerTextFieldForRegistration("Login with Email Address"),

                  //second text on the page
                  secondHeaderForRegistration(
                      "Please type your email and password to\ncontinue to your account",
                      false),

                  //Textfield for email
                  textFieldHeaderOfRegistration("Email Address"),
                  Container(
                      height: 53,
                      padding: EdgeInsets.fromLTRB(55, 5, 55, 5),
                      child: Material(
                        elevation: 2,
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                        child: TextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                          ],
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
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
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(32, 32, 32, 0.5))),
                        ),
                      )),

                  //Textfield for password
                  textFieldHeaderOfRegistration("Password"),
                  Container(
                      height: 53,
                      padding: EdgeInsets.fromLTRB(55, 5, 55, 5),
                      child: Material(
                        elevation: 2,
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
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
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(32, 32, 32, 0.5))),
                        ),
                      )),

                  ErrorMessage(error),
                  //button to continue
                  BlocProvider(
                    create: (context) => bloc,
                    child: BlocListener<LoginforgotresetBloc,
                        LoginforgotresetState>(
                      listener: (context, state) {
                        if (state is LoginforgotresetLoadedwithResponse) {
                          if (state.code == 200) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TabSelector(true, 0, 0),
                                ), (route) {
                              return route == context ? true : false;
                            });
                          } else {
                            setState(() {
                              error = state.response['feedback'].toString();
                            });
                          }
                        }
                      },
                      child: BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is LoginforgotresetInitial) {
                            return continueButton();
                          } else if (state is LoginforgotresetLoading) {
                            return loadingCircle();
                          } else if (state
                              is LoginforgotresetLoadedwithResponse) {
                            return continueButton();
                          }
                        },
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child: Container(
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(129, 187, 46, 1)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return Container(
        padding: EdgeInsets.fromLTRB(55, 30, 55, 30),
        alignment: Alignment.center,
        child: Material(
          elevation: 3,
          shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color.fromRGBO(139, 187, 46, 1),
          child: FlatButton(
            height: 40,
            minWidth: 295,
            color: Color.fromRGBO(139, 187, 46, 1),
            textColor: Colors.white,
            child: Text(
              "Login",
            ),
            onPressed: () {
              if (emailController.text.toString() == "" ||
                  passController.text.toString() == "") {
                setState(() {
                  error = "All fields need to be filled up!";
                });
              } else {
                setState(() {
                  error = "";
                });
                bloc.add(checkLogin(emailController.text.toString(),
                    passController.text.toString()));
              }
            },
          ),
        ));
  }
}
