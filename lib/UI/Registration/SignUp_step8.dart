import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:revised_quickassist/Model/registrationInformation.dart';
import 'package:revised_quickassist/UI/Login_Forgot_Password/login.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/bloc/Bloc/registrationmethods_bloc.dart';
import 'package:stripe_payment/stripe_payment.dart';

class Sign_up_step8 extends StatefulWidget {
  _Sign_up_step8_state createState() {
    return new _Sign_up_step8_state();
  }
}

class _Sign_up_step8_state extends State<Sign_up_step8> {
  final bloc = new RegistrationmethodsBloc();
  final noc = TextEditingController();
  TextEditingController cn =
      new MaskedTextController(mask: '0000 0000 0000 0000 000');
  TextEditingController exp = new MaskedTextController(mask: '00/00');
  TextEditingController ccv = new MaskedTextController(mask: '0000');
  int statusCode, picStatusCode;
  double width;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool visibilityButton = true;
  bool cont = true;
  CreditCard testCard;

  @override
  void dispose() {
    noc.dispose();
    cn.dispose();
    exp.dispose();
    ccv.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    StripePayment.setOptions(StripeOptions(
        publishableKey: "",
        merchantId: "Test",
        //YOUR_MERCHANT_ID
        androidPayMode: 'test'));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromRGBO(101, 101, 101, 1)),
          child: Text(
            error.toString().split(",")[1],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        )));
    setState(() {
      visibilityButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;
    return Scaffold(
        key: _scaffoldKey,
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
                            child: SvgPicture.asset("assets/credit-card.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) - ((width / 6) * 0.5)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                      ],
                    ),
                  )),
              headerTextFieldForRegistration(
                  "We charge a one-time registration\nfee to help our platform safe"),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width,
                height: 1,
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                color: Color.fromRGBO(101, 101, 101, 0.26),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 0,
                        child: SvgPicture.asset("assets/Group 692.svg")),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Container(
                      child: Text(
                        "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(13, 106, 106, 1)),
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                width: width,
                height: 1,
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                color: Color.fromRGBO(101, 101, 101, 0.26),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                width: width,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(
                          "Registration Fee",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color.fromRGBO(39, 39, 39, 1)),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                          child: Text(
                            "\$15",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Color.fromRGBO(39, 39, 39, 1)),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                width: width,
                height: 1,
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                color: Color.fromRGBO(101, 101, 101, 0.26),
              ),
              SizedBox(
                height: 10,
              ),
              textFieldHeaderOfRegistration("Name on Card"),
              Container(
                  width: width,
                  margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                  child: Material(
                    elevation: 2,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                    child: TextField(
                      controller: noc,
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
                          hintText: "Name on Card",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  )),
              textFieldHeaderOfRegistration("Card Number"),
              Container(
                  width: width,
                  margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
                  child: Material(
                    elevation: 2,
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: cn,
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
                          hintText: "Card Number",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  )),
              Container(
                width: width,
                margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
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
                                "Expiration",
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
                                keyboardType: TextInputType.number,
                                controller: exp,
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
                                    hintText: "MM/YY",
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
                        flex: 2,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                "CCV/CVC",
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
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                controller: ccv,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                decoration: InputDecoration(
                                    counterText: "",
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
                                    hintText: "Type Code",
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
                width: cont ? 0 : width,
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
              BlocProvider(
                create: (context) => bloc,
                child: BlocListener<RegistrationmethodsBloc,
                    RegistrationmethodsState>(
                  listener: (context, state) {
                    if (state is RegistrationmethodsLoaded) {
                      var response = state.response;
                      if (response != null) {
                        if (response.statusCode != 200) {
                          snackbar(_scaffoldKey,
                                  "Error while saving! Please try again!")
                              .showSnackbar();
                        } else {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => login()),
                              (route) {
                            return route == context ? true : false;
                          });
                        }
                      }
                    }
                  },
                  child: BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is RegistrationmethodsInitial) {
                          return continueButton();
                        } else if (state is RegistrationmethodsLoading) {
                          return loadingCircle();
                        } else if (state is RegistrationmethodsLoaded) {
                          return continueButton();
                        }
                      }),
                ),
              )
            ]))));
  }

  continueButton() {
    return Container(
      width: width,
      margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
      alignment: Alignment.bottomCenter,
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
              if (ccv.text.toString() == "" ||
                  cn.text.toString() == "" ||
                  exp.text.toString() == "" ||
                  noc.text.toString() == "") {
                setState(() {
                  cont = false;
                });
              } else {
                bloc.add(addPaymentMethodAndRegister(
                    _scaffoldKey,
                    ccv.text.toString(),
                    cn.text.toString(),
                    exp.text.toString(),
                    noc.text.toString()));
              }
              ;
            },
          )),
    );
  }
}
