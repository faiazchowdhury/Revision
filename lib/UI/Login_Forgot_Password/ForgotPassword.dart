import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revised_quickassist/UI/Login_Forgot_Password/ResetPassword.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/bloc/Bloc/loginforgotreset_bloc.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPasswordState createState() {
    return new ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  String error = "";
  final bloc = new LoginforgotresetBloc();

  @override
  void dispose() {
    bloc.close();
    emailController.dispose();
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
                headerTextFieldForRegistration("Forgot Password"),

                //second text on the page
                secondHeaderForRegistration(
                    "Please type your email, we will send\npassword reset code",
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
                ErrorMessage(error),
                BlocProvider(
                  create: (context) => bloc,
                  child: BlocListener(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is LoginforgotresetLoadedwithResponse) {
                        if (state.code == 500) {
                          setState(() {
                            error = "";
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword(
                                      emailController.text.toString())));
                        } else if (state.code == 500) {
                          setState(() {
                            error = "Server Error!";
                          });
                        } else {
                          setState(() {
                            error = "Email doesn't exist!";
                          });
                        }
                      }
                    },
                    child: BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is LoginforgotresetLoading) {
                          return loadingCircle();
                        } else if (state
                                is LoginforgotresetLoadedwithResponse ||
                            state is LoginforgotresetInitial) {
                          return continueButton();
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ]))),
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
              "Submit",
            ),
            onPressed: () async {
              if (emailController.text == "") {
                setState(() {
                  error = "Field can't be left empty!";
                });
              } else {
                setState(() {
                  error = "";
                });
                bloc.add(forgotPassword(emailController.text.toString()));
              }
            },
          )),
    );
  }
}
