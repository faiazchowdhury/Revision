import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:quick_assist/SignUp_step2.dart';
//import 'package:quick_assist/registration_storage.dart';
//import 'package:quick_assist/textfield1.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/bloc/Bloc/registrationmethods_bloc.dart';
import 'SignUp_step2.dart';

class SignUp_step1 extends StatefulWidget {
  _SignUp_step1_state createState() {
    return new _SignUp_step1_state();
  }
}

class _SignUp_step1_state extends State<SignUp_step1> {
  bool flag_state = false;
  int stateCode = 0;
  final myController1 = TextEditingController();
  bool cont1 = true;
  final myController2 = TextEditingController();
  bool cont2 = true;
  final myController3 = TextEditingController();
  bool cont3 = true;
  bool _flag = false;
  double width;
  double newheight;
  final bloc = new RegistrationmethodsBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    newheight = height - padding.top - padding.bottom;
    return Scaffold(
      //back button on the app bar
      appBar: appBarRegistration.appBar(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              //image of the page
              Container(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/Group 232.svg",
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
                            child:
                                SvgPicture.asset("assets/identification.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ((width / 2) - ((width / 6) * 1)), 0, 0, 0),
                            child: SvgPicture.asset("assets/Ellipse 23.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ((width / 2) + ((width / 6) * 0.5)), 0, 0, 0),
                            child: SvgPicture.asset("assets/Ellipse 23.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ((width / 2) + ((width / 6) * 2)), 0, 0, 0),
                            child: SvgPicture.asset("assets/Ellipse 23.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ((width / 2) + ((width / 6) * 3.5)), 0, 0, 0),
                            child: SvgPicture.asset("assets/Ellipse 23.svg")),
                      ],
                    ),
                  )),

              //first text on the page
              headerTextFieldForRegistration("Provide Personal Information"),

              //second text on the page
              secondHeaderForRegistration(
                  "Enter your name as it appears on your\ngovernment-issued ID",
                  true),

              //Input Textfield of Firstname
              textFieldHeaderOfRegistration("Full Name"),
              Container(
                  margin: EdgeInsets.fromLTRB(55, 5, 55, 5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  height: 49,
                  width: width,
                  child: Material(
                      elevation: 2,
                      shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                      child: TextField(
                        controller: myController1,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14),
                        maxLines: 1,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            errorText:
                                cont1 ? null : "Field can't be left empty",
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
                            hintText: "First Name",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(32, 32, 32, 0.5))),
                      ))),

              //Input Textfield of Lastname
              textFieldHeaderOfRegistration("Email"),
              Container(
                  margin: EdgeInsets.fromLTRB(55, 5, 55, 5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  height: 49,
                  width: width,
                  child: Material(
                    elevation: 2,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                      ],
                      keyboardType: TextInputType.emailAddress,
                      controller: myController2,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          errorText: cont2 ? null : "Field can't be left empty",
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
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  )),

              //Input Textfield of pass
              textFieldHeaderOfRegistration("Password"),
              Container(
                  margin: EdgeInsets.fromLTRB(55, 5, 55, 5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  height: 49,
                  width: width,
                  child: Material(
                    elevation: 2,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                    child: TextField(
                      controller: myController3,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          errorText: cont3 ? null : "Field can't be left empty",
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
                                color: Color.fromRGBO(117, 117, 117, 0.7),
                              )),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  )),

              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                width: width,
                child: Center(
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Color.fromRGBO(139, 187, 46, 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: CheckboxListTile(
                        title: Text(
                          "I am a sole proprietor or other business entity",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(31, 49, 74, 0.45)),
                        ),
                        activeColor: Color.fromRGBO(139, 187, 46, 1),
                        value: _flag,
                        onChanged: (bool v) {
                          setState(() {
                            _flag = v;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: stateCode != 200 && stateCode != 0,
                child: Container(
                    width: 200,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_rounded,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          stateCode >= 500
                              ? "Internal Server Error"
                              : "Email Already Exists!",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    )),
              ),
              Visibility(
                  visible: flag_state,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "In order to continue, you need to select the checkbox",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                  )),
              //button to continue
              BlocProvider(
                create: (context) => bloc,
                child: BlocListener<RegistrationmethodsBloc,
                    RegistrationmethodsState>(
                  listener: (context, state) {
                    if (state is RegistrationmethodsLoaded) {
                      setState(() {
                        stateCode = state.response.statusCode;
                      });
                      if (state.response.statusCode == 200) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp_step2()));
                      }
                    }
                  },
                  child: BlocBuilder(
                      bloc: bloc,
                      builder: (context, RegistrationmethodsState state) {
                        if (state is RegistrationmethodsInitial) {
                          return continueButton(state);
                        } else if (state is RegistrationmethodsLoading) {
                          return loadingCircle();
                        } else if (state is RegistrationmethodsLoaded) {
                          return continueButton(state);
                        } else {
                          return Container();
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  continueButton(RegistrationmethodsState state) {
    return Container(
      height: 50,
      width: width,
      margin: EdgeInsets.fromLTRB(55, 0, 55, 30),
      alignment: Alignment.center,
      child: Material(
          elevation: 3,
          shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color.fromRGBO(139, 187, 46, 1),
          child: FlatButton(
            height: 40,
            minWidth: width,
            color: Color.fromRGBO(139, 187, 46, 1),
            textColor: Colors.white,
            child: Text(
              "Continue",
            ),
            onPressed: () async {
              if (myController1.text == "") {
                setState(() {
                  cont1 = false;
                });
              } else {
                if (myController2.text == "") {
                  setState(() {
                    cont1 = true;
                    cont2 = false;
                  });
                } else {
                  if (myController3.text == "") {
                    setState(() {
                      cont2 = true;
                      cont3 = false;
                    });
                  } else {
                    if (_flag == false) {
                      setState(() {
                        flag_state = true;
                      });
                    } else {
                      setState(() {
                        flag_state = false;
                      });
                      cont3 = true;
                      bloc.add(emailCheckRegistration(
                          myController2.text.toString(),
                          myController1.text.toString(),
                          myController3.text.toString(),
                          _flag));
                      if (stateCode == 200 &&
                          state is RegistrationmethodsLoaded) {
                        print("nextPage");
                      }
                    }
                  }
                  ;
                }
              }
            },
          )),
    );
  }
}
