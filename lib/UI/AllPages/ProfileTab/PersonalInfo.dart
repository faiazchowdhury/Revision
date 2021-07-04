import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Model/listOfInfo.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class PersonalInfo extends StatefulWidget {
  @override
  PersonalInfoState createState() => PersonalInfoState();
}

class PersonalInfoState extends State<PersonalInfo> {
  double width, height;
  bool selectedVehicle = true;
  String vehicleHint = "No Vehicle", error = "";
  final bloc = new ProfileBloc();
  final saveButtonBloc = new ProfileBloc();
  TextEditingController personalInfoController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffAboutMeKey = new GlobalKey();

  @override
  void initState() {
    bloc.add(getPersonalInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffAboutMeKey,
      backgroundColor: Colors.white,
      appBar: AllPagesAppBar.appBar(context, true, false, "Profile Edit"),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => bloc,
              ),
              BlocProvider(
                create: (context) => saveButtonBloc,
              )
            ],
            child: BlocListener(
              bloc: bloc,
              listener: (context, state) {
                if (state is ProfileLoadedwithResponse) {
                  if (state.code != 200) {
                    snackbar(scaffAboutMeKey,
                            "Something went wrong! Please Try again!")
                        .showSnackbar();
                  } else {
                    personalInfoController.text = state.response['about_me'];
                    vehicleHint = state.response['vehicle'];
                  }
                }
              },
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ProfileInitial) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 50,
                        height: 50,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircularProgressIndicator()));
                  } else if (state is ProfileLoading) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 50,
                        height: 50,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircularProgressIndicator()));
                  } else if (state is ProfileLoadedwithResponse) {
                    return display();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget display() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Personal Information",
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
                    "About me",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 247, 247, 1),
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: Color.fromRGBO(117, 117, 117, 0.7)),
                    ),
                    height: 215,
                    child: TextFormField(
                      controller: personalInfoController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        hintText: "Write here...",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(32, 32, 32, 0.5),
                            fontSize: 15),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Vehicle for Service",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVehicle = !selectedVehicle;
                    });
                  },
                  child: Center(
                    child: AnimatedContainer(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(117, 117, 117, 0.7)),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Color.fromRGBO(247, 247, 247, 1),
                      ),
                      height: selectedVehicle ? 52.0 : 250.0,
                      duration: Duration(milliseconds: 0),
                      curve: Curves.fastOutSlowIn,
                      child: selectedVehicle
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
                                        vehicleHint,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(32, 32, 32, 1),
                                            fontSize: 15),
                                      )),
                                  Flexible(
                                    flex: 0,
                                    fit: FlexFit.tight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        selectedVehicle
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
                                              vehicleHint,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      32, 32, 32, 1),
                                                  fontSize: 15),
                                            )),
                                        Flexible(
                                          flex: 0,
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(
                                                selectedVehicle
                                                    ? Icons
                                                        .keyboard_arrow_down_outlined
                                                    : Icons
                                                        .keyboard_arrow_up_outlined,
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1)),
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
                                      child: ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  Divider(
                                                    endIndent: 10,
                                                    indent: 10,
                                                    height: 1,
                                                    thickness: 1,
                                                    color: Color.fromRGBO(
                                                        101, 101, 101, 0.2),
                                                  ),
                                          itemCount:
                                              listOfInfo.vehicleType.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              title: Text(
                                                  listOfInfo.vehicleType[index],
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          101, 101, 101, 1),
                                                      fontSize: 15)),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              onTap: () {
                                                setState(() {
                                                  selectedVehicle = true;
                                                  vehicleHint = listOfInfo
                                                      .vehicleType[index];
                                                });
                                              },
                                            );
                                          })),
                                ),
                              ],
                            ),
                    ),
                  ),
                ) // snapshot.data  :- get your object which is pass from your downloadData() function

                    ),
                SizedBox(
                  height: 30,
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
                        snackbar(scaffAboutMeKey, "Information Saved!")
                            .showSnackbar();
                      } else {
                        snackbar(scaffAboutMeKey,
                                "Information could not be saved! Try again")
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
            )));
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () {
        if (personalInfoController.text.toString() == "") {
          setState(() {
            error = "Fields can't be left empty!";
          });
        } else {
          setState(() {
            error = "";
          });
          saveButtonBloc.add(
              changePersonalInfo(personalInfoController.text, vehicleHint));
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
