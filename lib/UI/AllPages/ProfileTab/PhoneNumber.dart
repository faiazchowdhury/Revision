import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class PhoneNumber extends StatefulWidget {
  @override
  PhoneNumberState createState() => PhoneNumberState();
}

class PhoneNumberState extends State<PhoneNumber> {
  double width, height;
  String error = "", ccode = "1";
  final bloc = new ProfileBloc();
  final saveButtonBloc = new ProfileBloc();
  TextEditingController phnNoController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffNumberKey = new GlobalKey();

  @override
  void initState() {
    bloc.add(getPhoneNumber());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffNumberKey,
      backgroundColor: Colors.white,
      appBar: AllPagesAppBar.appBar(context, true, false, "Profile Edit"),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (BuildContext context) => bloc,
                  ),
                  BlocProvider(
                    create: (BuildContext context) => saveButtonBloc,
                  ),
                ],
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone Number",
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
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Country",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color.fromRGBO(101, 101, 101, 1)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(117, 117, 117, 0.7),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Color.fromRGBO(247, 247, 247, 1),
                      ),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return CountryPickerDropdown(
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Color.fromRGBO(13, 106, 106, 1),
                            ),
                            initialValue: "US",
                            itemFilter:
                                true ? (c) => ['US'].contains(c.isoCode) : "",
                            itemBuilder: (Country country) => Container(
                                width: constraints.maxWidth - 30,
                                child: Text(
                                  "  ${country.name}",
                                  textAlign: TextAlign.left,
                                )),
                            onValuePicked: (Country country) {
                              setState(() {
                                ccode = country.phoneCode;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //phone number
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone Number",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color.fromRGBO(101, 101, 101, 1)),
                      ),
                    ),

                    BlocListener(
                      bloc: bloc,
                      listener: (context, state) {
                        if (state is ProfileLoadedwithResponse) {
                          if (state.code == 200) {
                            phnNoController.text =
                                state.response['phone_number'];
                          } else {
                            snackbar(scaffNumberKey,
                                "Something went wrong! Try again!");
                          }
                        }
                      },
                      child: BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is ProfileInitial) {
                            return loadingCircle();
                          } else if (state is ProfileLoading) {
                            return loadingCircle();
                          } else if (state is ProfileLoadedwithResponse) {
                            return displayNumber();
                          }
                        },
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    ErrorMessage(error),
                    SizedBox(
                      height: 20,
                    ),
                    BlocListener(
                      bloc: saveButtonBloc,
                      listener: (context, state) {
                        if (state is ProfileLoadedwithResponse) {
                          if (state.code == 200) {
                            snackbar(scaffNumberKey, "Phone Number Changed!")
                                .showSnackbar();
                          } else {
                            snackbar(scaffNumberKey, "Couldn't change number!")
                                .showSnackbar();
                          }
                        }
                      },
                      child: BlocBuilder(
                        bloc: saveButtonBloc,
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

                    SizedBox(
                      height: 30,
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
      ),
    );
  }

  Widget displayNumber() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Material(
          elevation: 2,
          shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
          child: Container(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              controller: phnNoController,
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
                          margin: const EdgeInsets.only(left: 5.0, right: 5),
                        ),
                      ]),
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(247, 247, 247, 1),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(117, 117, 117, 0.7),
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(117, 117, 117, 0.1),
                      )),
                  hintText: "Number",
                  hintStyle: TextStyle(
                      fontSize: 15, color: Color.fromRGBO(32, 32, 32, 0.5))),
            ),
          ),
        ));
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () {
        if (phnNoController.text.toString() == "") {
          setState(() {
            error = "Fields can't be left empty!";
          });
        } else {
          setState(() {
            error = "";
          });
          saveButtonBloc
              .add(changePhoneNumber(phnNoController.text.toString()));
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
