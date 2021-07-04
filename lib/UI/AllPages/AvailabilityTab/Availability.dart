import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:revised_quickassist/UI/AllPages/AvailabilityTab/AddSchedule.dart';
import 'package:revised_quickassist/UI/AllPages/Notifications.dart';
import 'package:revised_quickassist/Model/availabilityListResponse.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/availability_bloc.dart';

class Availability extends StatefulWidget {
  @override
  AvailabilityState createState() => AvailabilityState();
}

class AvailabilityState extends State<Availability> {
  double width, height;
  final bloc = new AvailabilityBloc();
  final deleteBloc = new AvailabilityBloc();
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey();

  @override
  void initState() {
    if (availabilityListResponse.getResponse == null) {
      bloc.add(getAvailability());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => bloc),
          BlocProvider(create: (context) => deleteBloc)
        ],
        child: Scaffold(
            key: scaffKey,
            backgroundColor: Colors.white,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is AvailabilityInitial ||
                    state is AvailabilityLoaded) {
                  return availabilityListResponse.getCode != 200
                      ? Container()
                      : Container(
                          height: 42,
                          padding: EdgeInsets.only(left: 60, right: 60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Material(
                            elevation: 2,
                            shadowColor: Color.fromRGBO(129, 187, 46, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Color.fromRGBO(139, 187, 46, 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FlatButton(
                                height: 40,
                                minWidth: width - 120,
                                color: Color.fromRGBO(139, 187, 46, 1),
                                textColor: Colors.white,
                                child: Text(
                                  "+ Add Schedule",
                                ),
                                onPressed: () async {
                                  await pushNewScreen(context,
                                      screen: AddSchedule(scaffKey));
                                  setState(() {});
                                },
                              ),
                            ),
                          ));
                } else if (state is AvailabilityLoading) {
                  return Container();
                }
              },
            ),
            appBar:
                AllPagesAppBar.appBar(context, false, true, "My Availability"),
            body: Container(
              alignment: Alignment.topCenter,
              child: BlocListener(
                bloc: bloc,
                listener: (context, state) {},
                child: BlocBuilder(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is AvailabilityInitial) {
                      return displayScreen();
                    } else if (state is AvailabilityLoading) {
                      return loadingCircle();
                    } else if (state is AvailabilityLoaded) {
                      return displayScreen();
                    }
                  },
                ),
              ),
            )));
  }

  Widget displayScreen() {
    var response = availabilityListResponse.getResponse;
    return availabilityListResponse.getCode != 200
        ? SomethingWentWrong()
        : response.length == 0
            ? Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "No Schedule Added yet!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(13, 106, 106, 0.29)),
                ),
              )
            : Container(
                width: width,
                height: height - 50,
                child: ListView.builder(
                  itemCount: response.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: response.length - 1 == index
                          ? EdgeInsets.only(bottom: 80)
                          : EdgeInsets.zero,
                      child: Container(
                          width: width - 60,
                          height: 120,
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Start Date",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      101, 101, 101, 1)),
                                            ),
                                          )),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      response[index]
                                                          ['starting_date'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              32,
                                                              32,
                                                              32,
                                                              1))))),
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Start Time",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      101, 101, 101, 1)),
                                            ),
                                          )),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      "${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(response[index]['starting_time']))}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              32, 32, 32, 1)))))
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "End Date",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      101, 101, 101, 1)),
                                            ),
                                          )),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      response[index]
                                                          ['ending_date'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              32,
                                                              32,
                                                              32,
                                                              1))))),
                                          Expanded(
                                              child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "End Time",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      101, 101, 101, 1)),
                                            ),
                                          )),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      "${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(response[index]['ending_time']))}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromRGBO(
                                                              32, 32, 32, 1)))))
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // return object of type Dialog
                                            return ButtonBarTheme(
                                                data: ButtonBarThemeData(
                                                    alignment: MainAxisAlignment
                                                        .center),
                                                child: AlertDialog(
                                                  title: Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: SvgPicture.asset(
                                                        "assets/warning.svg"),
                                                  ),
                                                  content: IntrinsicHeight(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Do you want to delete this Schedule?",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            "Deleting this schedule will delete it from availability list. You will need to add new schedule to be available for the client again.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          BlocListener(
                                                            bloc: deleteBloc,
                                                            listener: (context,
                                                                state) {
                                                              if (state
                                                                  is AvailabilityLoadedWithResponse) {
                                                                Navigator.pop(
                                                                    context);
                                                                if (state
                                                                        .code ==
                                                                    200) {
                                                                  snackbar(
                                                                          scaffKey,
                                                                          "Deleted schedule successfully!")
                                                                      .showSnackbar();
                                                                } else {
                                                                  snackbar(
                                                                          scaffKey,
                                                                          "Something went wrong! Please try again!")
                                                                      .showSnackbar();
                                                                }
                                                              }
                                                            },
                                                            child: BlocBuilder(
                                                              bloc: deleteBloc,
                                                              builder: (context,
                                                                  state) {
                                                                if (state
                                                                    is AvailabilityInitial) {
                                                                  return deleteButton(
                                                                      response,
                                                                      index);
                                                                } else if (state
                                                                    is AvailabilityLoading) {
                                                                  return loadingCircle();
                                                                } else if (state
                                                                    is AvailabilityLoadedWithResponse) {
                                                                  return deleteButton(
                                                                      response,
                                                                      index);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          BlocBuilder(
                                                            bloc: deleteBloc,
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                      is AvailabilityInitial ||
                                                                  state
                                                                      is AvailabilityLoadedWithResponse) {
                                                                return FlatButton(
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            129,
                                                                            187,
                                                                            46,
                                                                            1)),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                );
                                                              } else if (state
                                                                  is AvailabilityLoading) {
                                                                return Container();
                                                              }
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // usually buttons at the bottom of the dialog
                                                  ],
                                                ));
                                          },
                                        );
                                        setState(() {});
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(255, 51, 73, 1),
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(5)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                  child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.white,
                                                ),
                                              )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                  child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Text("Delete",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors
                                                                  .white))))
                                            ],
                                          )),
                                    ))
                              ],
                            ),
                          )),
                    );
                  },
                ),
              );
  }

  Widget deleteButton(response, int index) {
    return Material(
        elevation: 3,
        shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Color.fromRGBO(129, 187, 46, 1),
        child: FlatButton(
          height: 40,
          minWidth: width / 1.3,
          color: Color.fromRGBO(129, 187, 46, 1),
          textColor: Colors.white,
          child: Text(
            "Delete Schedule",
            style: TextStyle(fontSize: 14),
          ),
          onPressed: () {
            setState(() {
              deleteBloc
                  .add(deleteAvailability(response[index]["id"].toString()));
            });
          },
        ));
  }
}
