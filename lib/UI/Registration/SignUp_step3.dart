import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:quick_assist/registration_storage.dart';
//import 'package:quick_assist/textfield1.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/itemDropDown.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/Model/registrationInformation.dart';
import 'package:revised_quickassist/bloc/Bloc/registrationmethods_bloc.dart';

import 'SignUp_step4.dart';

class SignUp_step3 extends StatefulWidget {
  String ccode;

  SignUp_step3(String c) {
    ccode = c;
  }

  _SignUp_step3_state createState() {
    return new _SignUp_step3_state(ccode);
  }
}

class _SignUp_step3_state extends State<SignUp_step3> {
  bool cont = true;
  var city;
  String ccode;
  bool selected = true;
  String hint = "- Select City";
  int selectedind;
  double newheight, width;
  final bloc = new RegistrationmethodsBloc();

  _SignUp_step3_state(String e) {
    ccode = e;
  }

  @override
  void initState() {
    bloc.add(getCityNames());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
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
                            SvgPicture.asset("assets/Group 232.svg"),
                            Container(
                                padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
                                child:
                                    SvgPicture.asset("assets/cityscape.svg")),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    ((width / 2) + ((width / 6) * 1)), 0, 0, 0),
                                child:
                                    SvgPicture.asset("assets/Ellipse 23.svg")),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    ((width / 2) - ((width / 6) * 0.5)),
                                    0,
                                    0,
                                    0),
                                child:
                                    SvgPicture.asset("assets/Ellipse 23.svg")),
                            Container(
                                padding: EdgeInsets.fromLTRB(0, 0,
                                    ((width / 2) - ((width / 6) * 0.5)), 0),
                                child:
                                    SvgPicture.asset("assets/Ellipse 27.svg")),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, ((width / 2) + ((width / 6) * 1)), 0),
                                child:
                                    SvgPicture.asset("assets/Ellipse 27.svg")),
                          ],
                        ),
                      )),

                  //first text on the page
                  headerTextFieldForRegistration("Please select nearby City"),

                  //second text on the page
                  secondHeaderForRegistration(
                      "Please select your nearby city", false),

                  //City Picker
                  Container(
                    height: 305,
                    width: width,
                    child: Column(
                      children: [
                        textFieldHeaderOfRegistration("City"),
                        BlocProvider(
                          create: (context) => bloc,
                          child: BlocListener<RegistrationmethodsBloc,
                              RegistrationmethodsState>(
                            listener: (context, state) {
                              if (state is RegistrationmethodsLoaded) {
                                setState(() {
                                  city = state.response;
                                });
                              }
                            },
                            child: BlocBuilder(
                                bloc: bloc,
                                builder: (context, state) {
                                  if (state is RegistrationmethodsInitial) {
                                    return loadingCircle();
                                  } else if (state
                                      is RegistrationmethodsLoading) {
                                    return loadingCircle();
                                  } else if (state
                                      is RegistrationmethodsLoaded) {
                                    return itemDropDown(
                                        List<String>.from(city['feedback']),
                                        hint,
                                        "select_city");
                                  }
                                }),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(55, 5, 55, 0),
                          width: cont ? 0 : width,
                          height: cont ? 0 : 15,
                          child: Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Need to select a City!",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                      margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                      alignment: Alignment.bottomCenter,
                      child: Material(
                          elevation: 3,
                          shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: Color.fromRGBO(139, 187, 46, 1),
                          child: FlatButton(
                            minWidth: width,
                            height: 40,
                            color: Color.fromRGBO(139, 187, 46, 1),
                            textColor: Colors.white,
                            child: Text(
                              "Continue",
                            ),
                            onPressed: () {
                              if (registrationInformation.getCity ==
                                  "- Select City") {
                                setState(() {
                                  cont = false;
                                });
                              } else {
                                cont = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp_step4()));
                              }
                              ;
                            },
                          )),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget dropDown() {
    ScrollController scrollcont = new ScrollController();
    return Center(
        child: GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(117, 117, 117, 0.7)),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromRGBO(247, 247, 247, 1),
          ),
          height: selected ? 52.0 : 250.0,
          duration: Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
          child: selected
              ?
              //Menu not clicked hence Collapsed
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Text(
                            hint,
                            style: TextStyle(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                fontSize: 15),
                          )),
                      Flexible(
                        flex: 0,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            selected
                                ? Icons.keyboard_arrow_down_outlined
                                : Icons.keyboard_arrow_up_outlined,
                            color: Color.fromRGBO(13, 106, 106, 1),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              :
              //Menu clicked hence Expanded
              Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: Text(
                                  hint,
                                  style: TextStyle(
                                      color: Color.fromRGBO(32, 32, 32, 1),
                                      fontSize: 15),
                                )),
                            Flexible(
                              flex: 0,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                    selected
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.keyboard_arrow_up_outlined,
                                    color: Color.fromRGBO(13, 106, 106, 1)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          height: 1.0,
                          color: Color.fromRGBO(13, 106, 106, 1),
                        )),
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Scrollbar(
                          thickness: 3,
                          isAlwaysShown: true,
                          controller: scrollcont,
                          child: ListView.separated(
                              controller: scrollcont,
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (BuildContext context,
                                      int index) =>
                                  Divider(
                                    endIndent: 10,
                                    indent: 10,
                                    height: 1,
                                    thickness: 1,
                                    color: Color.fromRGBO(101, 101, 101, 0.2),
                                  ),
                              itemCount: city['feedback'].length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(city['feedback'][index],
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(101, 101, 101, 1),
                                          fontSize: 15)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  onTap: () {
                                    setState(() {
                                      selected = true;
                                      hint = city['feedback'][index];
                                    });
                                  },
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    )); // snapshot.data  :- get your object which is pass from your downloadData() function
  }
}
