import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:revised_quickassist/UI/AllPages/TabSelector.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';
import 'package:revised_quickassist/config/config.dart';

import 'UI/Login_Forgot_Password/login.dart';
import 'UI/Policies/Cookies_policy.dart';
import 'UI/Policies/Privacy_policy.dart';
import 'UI/Policies/Terms_of_services.dart';
import 'UI/Registration/SignUp_step1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final tokenBloc = new ProfileBloc();

  @override
  void initState() {
    config.seturl();
    tokenBloc.add(getToken());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return BlocProvider(
              create: (context) => tokenBloc,
              child: BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileTokenStateLoaded) {
                      if (state.code == 200) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => TabSelector(true, 0, 0)),
                            (route) => route == MyApp());
                      }
                    }
                  },
                  child: BlocBuilder(
                      bloc: tokenBloc,
                      builder: (context, state) {
                        if (state is ProfileInitial) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/Quick Assist.png",
                                  scale: 3,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CircularProgressIndicator()
                              ],
                            ),
                          );
                        } else if (state is ProfileLoading) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/Quick Assist.png",
                                  scale: 3,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CircularProgressIndicator()
                              ],
                            ),
                          );
                        } else if (state is ProfileTokenStateLoaded) {
                          if (state.code == 200) {
                            return Container();
                          } else {
                            return Scaffold(
                                backgroundColor: Colors.white,
                                body: Container(
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: SafeArea(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                30, 0, 30, 0),
                                            child: Image.asset(
                                              "assets/Quick Assist.png",
                                              scale: 2,
                                            ),
                                          ),
                                          Text("For Service Provider",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                              child: SvgPicture.asset(
                                            "assets/Group 679.svg",
                                          )),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                50, 30, 50, 10),
                                            child: Material(
                                                elevation: 3,
                                                shadowColor: Color.fromRGBO(
                                                    129, 187, 46, 0.39),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                color: Color.fromRGBO(
                                                    139, 187, 46, 1),
                                                child: FlatButton(
                                                  height: 40,
                                                  minWidth: 280,
                                                  color: Color.fromRGBO(
                                                      139, 187, 46, 1),
                                                  textColor: Colors.white,
                                                  child: Text(
                                                    "Sign Up",
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            SignUp_step1(),
                                                        transitionsBuilder:
                                                            (context,
                                                                animation,
                                                                secondaryAnimation,
                                                                child) {
                                                          final begin =
                                                              Offset(1, 0);
                                                          final end =
                                                              Offset.zero;
                                                          final curve =
                                                              Curves.decelerate;
                                                          final tween = Tween(
                                                                  begin: begin,
                                                                  end: end)
                                                              .chain(CurveTween(
                                                                  curve:
                                                                      curve));
                                                          return SlideTransition(
                                                            position: animation
                                                                .drive(tween),
                                                            child: child,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Material(
                                                elevation: 3,
                                                shadowColor: Color.fromRGBO(
                                                    129, 187, 46, 0.39),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    side: BorderSide(
                                                      color: Color.fromRGBO(
                                                          139, 187, 46, 1),
                                                    )),
                                                child: FlatButton(
                                                  height: 40,
                                                  minWidth: 280,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: Colors.white,
                                                  textColor: Color.fromRGBO(
                                                      139, 187, 46, 1),
                                                  child: Text(
                                                    "Log In",
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            login(),
                                                        transitionsBuilder:
                                                            (context,
                                                                animation,
                                                                secondaryAnimation,
                                                                child) {
                                                          final begin =
                                                              Offset(1, 0);
                                                          final end =
                                                              Offset.zero;
                                                          final curve =
                                                              Curves.decelerate;
                                                          final tween = Tween(
                                                                  begin: begin,
                                                                  end: end)
                                                              .chain(CurveTween(
                                                                  curve:
                                                                      curve));
                                                          return SlideTransition(
                                                            position: animation
                                                                .drive(tween),
                                                            child: child,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                )),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 20, 10, 2),
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        "By signing for Quickassist, you agree to our ",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1),
                                                        fontSize: 10)),
                                                TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              Navigator.push(
                                                                  context,
                                                                  PageRouteBuilder(
                                                                    pageBuilder: (context,
                                                                            animation,
                                                                            secondaryAnimation) =>
                                                                        Terms_of_services(),
                                                                    transitionsBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                      final begin =
                                                                          Offset(
                                                                              1,
                                                                              0);
                                                                      final end =
                                                                          Offset
                                                                              .zero;
                                                                      final curve =
                                                                          Curves
                                                                              .decelerate;
                                                                      final tween = Tween(
                                                                              begin: begin,
                                                                              end: end)
                                                                          .chain(CurveTween(curve: curve));
                                                                      return SlideTransition(
                                                                        position:
                                                                            animation.drive(tween),
                                                                        child:
                                                                            child,
                                                                      );
                                                                    },
                                                                  )),
                                                    text: "Terms of Service",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            139, 187, 46, 1),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 10)),
                                                TextSpan(
                                                    text: ". Learn\n",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1),
                                                        fontSize: 10)),
                                                TextSpan(
                                                    text:
                                                        "how we process your data in our ",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1),
                                                        fontSize: 10)),
                                                TextSpan(
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () =>
                                                            Navigator.push(
                                                                context,
                                                                PageRouteBuilder(
                                                                  pageBuilder: (context,
                                                                          animation,
                                                                          secondaryAnimation) =>
                                                                      Privacy_policy(),
                                                                  transitionsBuilder: (context,
                                                                      animation,
                                                                      secondaryAnimation,
                                                                      child) {
                                                                    final begin =
                                                                        Offset(
                                                                            1,
                                                                            0);
                                                                    final end =
                                                                        Offset
                                                                            .zero;
                                                                    final curve =
                                                                        Curves
                                                                            .decelerate;
                                                                    final tween = Tween(
                                                                            begin:
                                                                                begin,
                                                                            end:
                                                                                end)
                                                                        .chain(CurveTween(
                                                                            curve:
                                                                                curve));
                                                                    return SlideTransition(
                                                                      position:
                                                                          animation
                                                                              .drive(tween),
                                                                      child:
                                                                          child,
                                                                    );
                                                                  },
                                                                )),
                                                  text: "Privacy Policy",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          139, 187, 46, 1),
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontSize: 10),
                                                ),
                                                TextSpan(
                                                    text: " and ",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1),
                                                        fontSize: 10)),
                                                TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              Navigator.push(
                                                                  context,
                                                                  PageRouteBuilder(
                                                                    pageBuilder: (context,
                                                                            animation,
                                                                            secondaryAnimation) =>
                                                                        Cookies_policy(),
                                                                    transitionsBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                      final begin =
                                                                          Offset(
                                                                              1,
                                                                              0);
                                                                      final end =
                                                                          Offset
                                                                              .zero;
                                                                      final curve =
                                                                          Curves
                                                                              .decelerate;
                                                                      final tween = Tween(
                                                                              begin: begin,
                                                                              end: end)
                                                                          .chain(CurveTween(curve: curve));
                                                                      return SlideTransition(
                                                                        position:
                                                                            animation.drive(tween),
                                                                        child:
                                                                            child,
                                                                      );
                                                                    },
                                                                  )),
                                                    text: "Cookies Policy",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            139, 187, 46, 1),
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontSize: 10)),
                                              ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          }
                        } else {
                          return Container();
                        }
                      })));
        },
      ),
    );
  }
}
