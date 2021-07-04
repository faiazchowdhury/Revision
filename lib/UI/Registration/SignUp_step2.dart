import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:quick_assist/registration_storage.dart';
//import 'package:quick_assist/textfield1.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:revised_quickassist/UI/Registration/SignUp_step3.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';
import 'package:revised_quickassist/Model/registrationInformation.dart';

//import 'SignUp_step3.dart';

class SignUp_step2 extends StatefulWidget {
  _SignUp_step2_state createState() {
    return new _SignUp_step2_state();
  }
}

class _SignUp_step2_state extends State<SignUp_step2> {
  String cname;
  String contcode = "AR";
  String ccode = "1";
  final myController = TextEditingController();
  bool cont = true;
  double newheight, width;

  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
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
                          child: SvgPicture.asset("assets/Group 604.svg")),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              ((width / 2) - ((width / 6) * 0.8)), 0, 0, 0),
                          child: SvgPicture.asset("assets/Ellipse 23.svg")),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              ((width / 2) + ((width / 6) * 0.5)), 0, 0, 0),
                          child: SvgPicture.asset("assets/Ellipse 23.svg")),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              ((width / 2) + ((width / 6) * 1.8)), 0, 0, 0),
                          child: SvgPicture.asset("assets/Ellipse 23.svg")),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, ((width / 2) - ((width / 6) * 0.8)), 0),
                          child: SvgPicture.asset("assets/Ellipse 27.svg")),
                    ],
                  ),
                )),

            //first text on the page

            headerTextFieldForRegistration("Provide your Phone Number"),

            //second text on the page
            secondHeaderForRegistration(
                "Please type your email & password\nfor your account", false),

            SizedBox(
              height: 10,
            ),

            //Country Picker
            textFieldHeaderOfRegistration("Country"),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(117, 117, 117, 0.7)),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Color.fromRGBO(247, 247, 247, 1),
              ),
              width: width,
              height: 49,
              margin: EdgeInsets.only(left: 55, right: 55),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return CountryPickerDropdown(
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Color.fromRGBO(13, 106, 106, 1),
                    ),
                    initialValue: "US",
                    itemFilter: true ? (c) => ['US'].contains(c.isoCode) : "",
                    itemBuilder: (Country country) => Container(
                        width: constraint.maxWidth - 30,
                        child: Text(
                          "  ${country.name}",
                          textAlign: TextAlign.left,
                        )),
                    onValuePicked: (Country country) {
                      setState(() {
                        cname = country.name;
                        ccode = country.phoneCode;
                        contcode = country.isoCode;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //phone number
            textFieldHeaderOfRegistration("Phone Number"),

            Container(
                margin: EdgeInsets.fromLTRB(55, 5, 55, 5),
                width: width,
                height: 49,
                child: Material(
                  elevation: 2,
                  shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: myController,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: SizedBox(
                            width: 60,
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(children: [
                                Text("   +${ccode}  ",
                                    style: TextStyle(
                                        color: Color.fromRGBO(45, 45, 45, 1),
                                        fontSize: 15)),
                                Container(
                                  height: 35.0,
                                  width: 0.5,
                                  color: Colors.black38,
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                ),
                              ]),
                            ),
                          ),
                          errorText: cont ? null : "Field can't be left empty",
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
                          hintText: "Number",
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(32, 32, 32, 0.5))),
                    ),
                  ),
                )),

            //button to continue
            Container(
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
                    height: 40,
                    minWidth: width,
                    color: Color.fromRGBO(139, 187, 46, 1),
                    textColor: Colors.white,
                    child: Text(
                      "Continue",
                    ),
                    onPressed: () {
                      if (myController.text == "") {
                        setState(() {
                          cont = false;
                        });
                      } else {
                        cont = true;
                        registrationInformation.setCountryPhoneNumber(
                            "United States", myController.text.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp_step3(contcode)));
                      }
                    },
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
