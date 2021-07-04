import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';

import 'SignUp_step7.dart';

class SignUp_step6 extends StatefulWidget {
  _SignUp_step6_state createState() {
    return new _SignUp_step6_state();
  }
}

class _SignUp_step6_state extends State<SignUp_step6> {
  double newheight, width;

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
        appBar: appBarRegistration.appBar(context),
        backgroundColor: Colors.white,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: newheight,
            child: SingleChildScrollView(
                child: Column(children: [
              SizedBox(
                height: 200,
                width: 200,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset("assets/Group 680.svg")),
              ),

              //first text on the page
              headerTextFieldForRegistration(
                  "To keep our platform Safe, All service providers need to complete a background check"),

              //second text on the page
              Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(101, 101, 101, 1),
                    ),
                  )),

              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                alignment: Alignment.bottomCenter,
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
                        "Continue",
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Sign_up_step7()));
                        ;
                      },
                    )),
              )
            ]))));
  }
}
