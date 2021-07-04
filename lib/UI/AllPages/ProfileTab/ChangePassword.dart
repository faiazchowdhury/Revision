import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  double width, height;
  String error = "";
  final bloc = new ProfileBloc();
  final GlobalKey<ScaffoldState> passChangeKey = new GlobalKey();
  TextEditingController oldPassController = new TextEditingController();
  TextEditingController newPassController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      key: passChangeKey,
      appBar: AllPagesAppBar.appBar(context, true, false, "Profile Edit"),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Change Password",
                      style: TextStyle(
                          color: Color.fromRGBO(13, 106, 106, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text(
                      "Old Password",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(101, 101, 101, 1)),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Material(
                        elevation: 2,
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                        child: TextField(
                          obscureText: true,
                          controller: oldPassController,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
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
                              hintText: "Old Password",
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(32, 32, 32, 0.5))),
                        ),
                      )),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text(
                      "New Password",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(101, 101, 101, 1)),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Material(
                        elevation: 2,
                        shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
                        child: TextField(
                          obscureText: true,
                          controller: newPassController,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14),
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
                              hintText: "New Password",
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(32, 32, 32, 0.5))),
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  ErrorMessage(error),
                  SizedBox(
                    height: 10,
                  ),
                  BlocProvider(
                    create: (context) => bloc,
                    child: BlocListener(
                      bloc: bloc,
                      listener: (context, state) {
                        if (state is ProfileLoadedwithResponse) {
                          if (state.response['feedback'].toString() ==
                              "Password does not match") {
                            snackbar(passChangeKey,
                                    "Entered the wrong password!")
                                .showSnackbar();
                          } else {
                            if (state.code == 500) {
                              snackbar(passChangeKey,
                                      "Something went wrong! Try again!")
                                  .showSnackbar();
                            } else {
                              snackbar(passChangeKey, "Password Changed!")
                                  .showSnackbar();
                            }
                          }
                        }
                      },
                      child: BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is ProfileInitial) {
                            return saveButton();
                          } else if (state is ProfileLoading) {
                            return loadingCircle();
                          } else if (state is ProfileLoadedwithResponse) {
                            return saveButton();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(129, 187, 46, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () {
        if (oldPassController.text.toString() == "" ||
            newPassController.text.toString() == "") {
          setState(() {
            error = " Fields can't be empty!";
          });
        } else {
          setState(() {
            error = "";
          });
          bloc.add(changePass(oldPassController.text.toString(),
              newPassController.text.toString()));
        }
      },
      child: Material(
        shadowColor: Color.fromRGBO(129, 187, 46, 1),
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 47,
          decoration: BoxDecoration(
            color: Color.fromRGBO(129, 187, 46, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Save Changes",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
