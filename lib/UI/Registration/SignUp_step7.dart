import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/Model/registrationInformation.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/datePickerRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';

import 'SignUp_step8.dart';

class Sign_up_step7 extends StatefulWidget {
  _Sign_up_step7_state createState() {
    return new _Sign_up_step7_state();
  }
}

class _Sign_up_step7_state extends State<Sign_up_step7> {
  DateTime selectedDate;
  final ssn = TextEditingController();
  final dob = TextEditingController();
  final streetNN = TextEditingController();
  final apt = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zip = TextEditingController();
  bool cont = true;
  double width, newheight;

  @override
  void dispose() {
    // TODO: implement dispose
    ssn.dispose();
    dob.dispose();
    streetNN.dispose();
    apt.dispose();
    city.dispose();
    state.dispose();
    zip.dispose();
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
            width: width,
            height: newheight,
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset("assets/Group 232.svg"),
                        Container(
                            padding: EdgeInsets.fromLTRB(2, 2, 0, 0),
                            child: SvgPicture.asset(
                                "assets/personal-information.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ((width / 2) - ((width / 6) * 0.5)), 0, 0, 0),
                            child: SvgPicture.asset("assets/Ellipse 23.svg")),
                      ],
                    ),
                  )),

              //first text on the page
              headerTextFieldForRegistration(
                  "We need some information to\nset up your payment account."),

              textFieldHeaderOfRegistration("Social Security Number"),
              Container(
                  margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                  width: width,
                  child: Material(
                    elevation: 2,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                    child: TextField(
                      maxLength: 9,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: ssn,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                          hintText: "Number",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),

              textFieldHeaderOfRegistration("Date of Birth"),
              datePickerRegistration(),

              SizedBox(
                height: 10,
              ),
              textFieldHeaderOfRegistration("Street Number & Name"),

              Container(
                  margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                  width: width,
                  child: Material(
                    elevation: 2,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                    child: TextField(
                      controller: streetNN,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                      maxLines: 1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                          hintText: "Street Number & Name",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                width: width,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                "Apt/Stuits",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            Material(
                              elevation: 2,
                              shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                              child: TextField(
                                controller: apt,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    filled: true,
                                    fillColor: Color.fromRGBO(247, 247, 247, 1),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    hintText: "Apt/Stuits",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(32, 32, 32, 0.5))),
                              ),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 0,
                        child: SizedBox(
                          width: 20,
                        )),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                "City",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            Material(
                              elevation: 1,
                              shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                              child: TextField(
                                controller: city,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    filled: true,
                                    fillColor: Color.fromRGBO(247, 247, 247, 1),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    hintText: "City Name",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(32, 32, 32, 0.5))),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                width: width,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                "State",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            Material(
                              elevation: 2,
                              shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                              child: TextField(
                                controller: state,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    filled: true,
                                    fillColor: Color.fromRGBO(247, 247, 247, 1),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    hintText: "State",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(32, 32, 32, 0.5))),
                              ),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 0,
                        child: SizedBox(
                          width: 20,
                        )),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                "Zip Code",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            Material(
                              elevation: 1,
                              shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: zip,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    filled: true,
                                    fillColor: Color.fromRGBO(247, 247, 247, 1),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              117, 117, 117, 0.7),
                                        )),
                                    hintText: "Zip Code",
                                    hintStyle: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(32, 32, 32, 0.5))),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: cont ? 0 : 290,
                height: cont ? 0 : 40,
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
                      "Need to fill up all the boxes!",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(55, 20, 55, 30),
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
                        if (zip.text.toString() == "" ||
                            city.text.toString() == "" ||
                            state.text.toString() == "" ||
                            streetNN.text.toString() == "" ||
                            ssn.text.toString() == "" ||
                            apt.text.toString() == "" ||
                            registrationInformation.getDOB == "") {
                          setState(() {
                            cont = false;
                          });
                        } else {
                          registrationInformation.setInfo(
                              ssn.text.toString(),
                              state.text.toString(),
                              apt.text.toString(),
                              city.text.toString(),
                              zip.text.toString(),
                              streetNN.text.toString());
                          setState(() {
                            cont = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Sign_up_step8()));
                          });
                        }
                        ;
                      },
                    )),
              )
            ]))));
  }
}
