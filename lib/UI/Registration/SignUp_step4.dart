import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/bloc/Bloc/registrationmethods_bloc.dart';
//import 'package:quick_assist/registration_storage.dart';
//import 'package:quick_assist/textfield1.dart';
import 'SignUp_step5.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/itemDropDown.dart';
import 'package:revised_quickassist/Widgets/appBarRegistration.dart';
import 'package:revised_quickassist/Widgets/headerForRegistration.dart';
import 'package:revised_quickassist/Widgets/secondHeaderForRegistration.dart';
import 'package:revised_quickassist/Widgets/textFieldHeaderOfRegistration.dart';

class SignUp_step4 extends StatefulWidget {
  _SignUp_step4_state createState() {
    return new _SignUp_step4_state();
  }
}

class _SignUp_step4_state extends State<SignUp_step4> {
  List<String> type = ['No vehicle', 'Sedan', 'Truck', 'Pick-Up'];
  List<String> services = [];
  List<String> suggestions = [];
  List<String> selectedServices = [];
  bool cont = true;
  bool check = false;
  bool selected = true, selectedVehicle = true;
  bool flag = true;
  int count;
  Widget icon = Icon(Icons.check_box_outline_blank_rounded);
  String hint = "Select services", vehicleHint = "No vehicle";
  final bloc = new RegistrationmethodsBloc();
  double width;
  double newheight;

  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    bloc.add(getServicesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    count = -1;
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
                                "assets/technical-support.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ((width / 2) - ((width / 6) * 1)), 0, 0, 0),
                            child: SvgPicture.asset("assets/Ellipse 23.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) + ((width / 6) * 2.5)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) + ((width / 6) * 1)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, ((width / 2) - ((width / 6) * 0.5)), 0),
                            child: SvgPicture.asset("assets/Ellipse 27.svg")),
                      ],
                    ),
                  )),

              //first text on the page
              headerTextFieldForRegistration(
                  "Please select Services that\nyou want to provide"),

              //second text on the page
              secondHeaderForRegistration(
                  "You can select multiple services", false),

              textFieldHeaderOfRegistration("Service"),

              BlocProvider(
                create: (context) => bloc,
                child: BlocListener<RegistrationmethodsBloc,
                    RegistrationmethodsState>(
                  listener: (context, state) {
                    if (state is RegistrationmethodsLoaded) {
                      services = List<String>.from(state.response['feedback']);
                    }
                  },
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is RegistrationmethodsInitial) {
                        return loadingCircle();
                      } else if (state is RegistrationmethodsLoading) {
                        return loadingCircle();
                      } else if (state is RegistrationmethodsLoaded) {
                        return dropDownSearchBar();
                      }
                    },
                  ),
                ),
              ),

              textFieldHeaderOfRegistration("Vehicle for Service"),
              itemDropDown(type, vehicleHint, "vehicle_selection"),

              Container(
                padding: EdgeInsets.fromLTRB(55, 50, 55, 30),
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
                        if (hint == "Select services") {
                          setState(() {
                            cont = false;
                          });
                        } else {
                          cont = true;
                          bloc.add(convertListToString(selectedServices));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp_step5()));
                        }
                      },
                    )),
              )
            ]))));
  }

  void suggestionSeeker(String value) {
    if (value.isNotEmpty) {
      suggestions.clear();
      services.forEach((element) {
        if (element.toUpperCase().startsWith(value.toUpperCase())) {
          suggestions.add(element);
        }
      });
      if (suggestions.isNotEmpty) {
        flag = false;
      } else {
        flag = true;
      }
      print(suggestions);
    } else {
      flag = true;
      suggestions.clear();
    }
    setState(() {});
  }

  selservices(String s) {
    print(selectedServices);
    if (selectedServices == null) {
      return false;
    } else {
      if (selectedServices.contains(s)) {
        return true;
      } else {
        return false;
      }
    }
  }

  Widget dropDownSearchBar() {
    return Container(
      width: width,
      margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selected = !selected;
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(117, 117, 117, 0.7),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color.fromRGBO(247, 247, 247, 1),
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 53,
                child: Row(
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: Text(
                          hint,
                          style: TextStyle(
                              color: Color.fromRGBO(32, 32, 32, 1),
                              fontSize: 15),
                        )),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text(
                        "& ${selectedServices.length - 1} More",
                        style: TextStyle(
                            color: selectedServices.length < 2
                                ? Colors.transparent
                                : Color.fromRGBO(32, 32, 32, 0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Icon(
                        selected
                            ? Icons.keyboard_arrow_down_outlined
                            : Icons.keyboard_arrow_up_outlined,
                        color: Color.fromRGBO(13, 106, 106, 1),
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(117, 117, 117, 0.7)),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Color.fromRGBO(247, 247, 247, 1),
            ),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: selected ? 0 : 200,
            width: selected ? 0 : width,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: TextField(
                        onChanged: (value) {
                          suggestionSeeker(value);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            border: InputBorder.none,
                            hintText: "Search",
                            suffixIcon: Icon(Icons.search_outlined),
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(101, 101, 101, 1),
                                fontSize: 14)),
                      )),
                ),
                Expanded(
                    flex: 0,
                    child: Container(
                      height: 1.0,
                      color: Color.fromRGBO(13, 106, 106, 1),
                      margin: EdgeInsets.only(left: 5.0, right: 5),
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Scrollbar(
                      thickness: 3,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 1,
                                thickness: 1,
                                color: Color.fromRGBO(101, 101, 101, 0.2),
                              ),
                          itemCount:
                              flag ? services.length : suggestions.length,
                          itemBuilder: (BuildContext context, int index) {
                            String s;
                            return SizedBox(
                              width: 5,
                              child: CheckboxListTile(
                                title: Text(
                                    s = flag
                                        ? services[index]
                                        : suggestions[index],
                                    style: TextStyle(
                                        color: Color.fromRGBO(101, 101, 101, 1),
                                        fontSize: 15)),
                                activeColor: Color.fromRGBO(139, 187, 46, 1),
                                value: selservices(s),
                                onChanged: (bool v) {
                                  setState(() {
                                    if (v == true) {
                                      hint = s;
                                      selectedServices.add(s);
                                    } else {
                                      selectedServices.remove(s);
                                      hint = hint == s
                                          ? (selectedServices.isEmpty
                                              ? "Select services"
                                              : selectedServices[0])
                                          : hint;
                                    }
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            );
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: cont ? 0 : width,
            height: cont ? 0 : 12,
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 12,
                ),
                Text(
                  "Need to select a service!",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
