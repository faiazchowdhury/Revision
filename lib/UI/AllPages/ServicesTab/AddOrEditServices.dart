import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/Model/allServicesList.dart';
import 'package:revised_quickassist/Model/serviceCategoryList.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/services_bloc.dart';

class AddOrEditServices extends StatefulWidget {
  final bool addServices;
  final int index;
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  AddOrEditServices(
    this.addServices,
    this.index,
    this.parentScaffoldKey,
  );

  @override
  AddOrEditServicesState createState() => AddOrEditServicesState();
}

class AddOrEditServicesState extends State<AddOrEditServices> {
  double width, height, addeditServicesRate;
  int index;
  bool addServicesDropDown = true, suggestionFlag = true;
  var response;
  List<String> suggestions = [];
  List<String> selectedServices = [];
  String addServicesHint = "Select Services";
  String error = "";
  final bloc = new ServicesBloc();
  final buttonBloc = new ServicesBloc();
  TextEditingController addServicesDescription = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    if (!widget.addServices) {
      response = allServicesList.getResponse;
      index = widget.index;
      addeditServicesRate = double.parse(response[index]['rate']);
      addServicesDescription.text = response[index]['description'];
    } else {
      if (serviceCategoryList.getResponse == null) {
        bloc.add(getServiceCategoryList());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          widget.addServices ? "Service Details" : "Edit Service Details",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        backgroundColor: Color.fromRGBO(13, 106, 106, 1),
        elevation: 5,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => bloc,
          ),
          BlocProvider(
            create: (BuildContext context) => buttonBloc,
          ),
        ],
        child: Container(
          height: height,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              width: width,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: width - 60,
                    child: Text(
                      "Service Type",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(101, 101, 101, 1)),
                    ),
                  ),
                  !widget.addServices
                      ? Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          width: width - 60,
                          height: 52,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(117, 117, 117, 0.7)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Color.fromRGBO(247, 247, 247, 1),
                          ),
                          child: Text(response[index]['service_name']),
                        )
                      : BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is ServicesInitial) {
                              return addServicesFromList();
                            } else if (state is ServicesLoading) {
                              return loadingCircle();
                            } else if (state is ServicesLoaded) {
                              return addServicesFromList();
                            }
                          },
                        ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    width: width - 60,
                    child: Text(
                      "Service Description",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(101, 101, 101, 1)),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 247, 1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color.fromRGBO(117, 117, 117, 0.7)),
                      ),
                      width: width - 60,
                      height: 215,
                      child: TextFormField(
                        controller: addServicesDescription,
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
                          hintText: "Write a description...",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(32, 32, 32, 0.5),
                              fontSize: 15),
                        ),
                      )),
                  Container(
                    width: width - 60,
                    height: 109,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              width: width - 60,
                              child: Text(
                                "Service Hourly Rate",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width / 4,
                                  height: 52,
                                  child: TextFormField(
                                    initialValue: !widget.addServices
                                        ? response[index]['rate']
                                        : null,
                                    onChanged: (value) {
                                      setState(() {
                                        addeditServicesRate =
                                            double.parse(value);
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9,.]')),
                                    ],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      fillColor:
                                          Color.fromRGBO(247, 247, 247, 1),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(117, 117, 117, 0.7),
                                      )),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(117, 117, 117, 0.7),
                                      )),
                                      hintText: "Rate",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(32, 32, 32, 0.5),
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                Text(
                                  " /Hour",
                                  style: TextStyle(
                                      color: Color.fromRGBO(32, 32, 32, 1),
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                              width: width - 60,
                              child: Text(
                                "Hourly Rate Comparision",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(101, 101, 101, 1)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 52,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(247, 247, 247, 1),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(117, 117, 117, 0.7))),
                              width: width / 3,
                              child: Text(
                                addeditServicesRate == null
                                    ? ""
                                    : addeditServicesRate < 12
                                        ? "Too Low"
                                        : addeditServicesRate >= 12 &&
                                                addeditServicesRate < 22
                                            ? "Moderate"
                                            : "Too High",
                                style: TextStyle(
                                    color: addeditServicesRate == null ||
                                            addeditServicesRate < 12 ||
                                            addeditServicesRate >= 22
                                        ? Color.fromRGBO(255, 35, 0, 1)
                                        : Color.fromRGBO(32, 32, 32, 1),
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  ErrorMessage(error),
                  BlocListener(
                    bloc: buttonBloc,
                    listener: (context, state) {
                      if (state is ServicesLoadedwithResponse) {
                        if (state.code != 200) {
                          snackbar(scaffoldKey,
                                  "Something went wrong! Please try again!")
                              .showSnackbar();
                        } else {
                          Navigator.pop(context);
                          snackbar(widget.parentScaffoldKey,
                                  "Successfully updated!")
                              .showSnackbar();
                        }
                      }
                    },
                    child: BlocBuilder(
                      bloc: buttonBloc,
                      builder: (context, state) {
                        if (state is ServicesInitial) {
                          return saveButton();
                        } else if (state is ServicesLoading) {
                          return loadingCircle();
                        } else if (state is ServicesLoadedwithResponse) {
                          return saveButton();
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: !widget.addServices,
                    child: BlocBuilder(
                      bloc: buttonBloc,
                      builder: (context, state) {
                        if (state is ServicesInitial) {
                          return deleteButton();
                        } else if (state is ServicesLoading) {
                          return Container();
                        } else if (state is ServicesLoadedwithResponse) {
                          return deleteButton();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addServicesFromList() {
    return serviceCategoryList.getServicesList == null
        ? Container()
        : Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    addServicesDropDown = !addServicesDropDown;
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
                    width: width - 60,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 53,
                    child: Row(
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            flex: 5,
                            child: Text(
                              addServicesHint,
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
                            addServicesDropDown
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
                height: addServicesDropDown ? 0 : 200,
                width: addServicesDropDown ? 0 : width - 60,
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                          width: width - 60,
                          color: Color.fromRGBO(13, 106, 106, 1),
                          margin: EdgeInsets.only(left: 5.0, right: 10),
                        )),
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Scrollbar(
                            thickness: 3,
                            child: ListView.separated(
                                separatorBuilder: (BuildContext context,
                                        int index) =>
                                    Divider(
                                      endIndent: 10,
                                      indent: 10,
                                      height: 1,
                                      thickness: 1,
                                      color: Color.fromRGBO(101, 101, 101, 0.2),
                                    ),
                                itemCount: suggestionFlag
                                    ? serviceCategoryList.getServicesList.length
                                    : suggestions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String s;
                                  return ListTile(
                                    title: Text(
                                        s = suggestionFlag
                                            ? serviceCategoryList
                                                .getServicesList[index]
                                            : suggestions[index],
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                101, 101, 101, 1),
                                            fontSize: 15)),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    onTap: () {
                                      setState(() {
                                        addServicesDropDown = true;
                                        addServicesHint = s;
                                      });
                                    },
                                  );
                                })),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
  }

  Widget saveButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
      child: Material(
          elevation: 3,
          shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color.fromRGBO(129, 187, 46, 1),
          child: FlatButton(
            height: 40,
            minWidth: width / 1.4,
            color: Color.fromRGBO(129, 187, 46, 1),
            textColor: Colors.white,
            child: Text(
              !widget.addServices ? "Save Changes" : "Save",
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              if (addServicesDescription.text == "" ||
                  addeditServicesRate == null) {
                setState(() {
                  error = "All boxes need to be filled!";
                });
              } else {
                if (addServicesHint == "Select Services" &&
                    widget.addServices) {
                  setState(() {
                    error = "All boxes need to be filled!";
                  });
                } else {
                  setState(() {
                    widget.addServices
                        ? buttonBloc.add(addService(addServicesHint,
                            addServicesDescription.text, addeditServicesRate))
                        : buttonBloc.add(editService(
                            response[index]['id'].toString(),
                            addServicesHint,
                            addServicesDescription.text,
                            addeditServicesRate));
                    error = "";
                  });
                }
              }
            },
          )),
    );
  }

  Widget deleteButton() {
    return Container(
        width: !widget.addServices ? width = width / 1.4 : 0,
        height: !widget.addServices ? 77 : 0,
        padding: EdgeInsets.only(bottom: 30),
        child: GestureDetector(
          onTap: () {
            // flutter defined function
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return ButtonBarTheme(
                    data:
                        ButtonBarThemeData(alignment: MainAxisAlignment.center),
                    child: AlertDialog(
                      title: Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset("assets/warning.svg"),
                      ),
                      content: IntrinsicHeight(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Do you want to delete this Service?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Text(
                                    "Deleting this service will delete the review related to this service.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Material(
                                  elevation: 3,
                                  shadowColor:
                                      Color.fromRGBO(129, 187, 46, 0.39),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  color: Color.fromRGBO(129, 187, 46, 1),
                                  child: FlatButton(
                                    height: 40,
                                    minWidth: width / 1.3,
                                    color: Color.fromRGBO(129, 187, 46, 1),
                                    textColor: Colors.white,
                                    child: Text(
                                      "Delete Service",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        buttonBloc.add(deleteService(
                                            response[index]['id'].toString()));
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color.fromRGBO(129, 187, 46, 1)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
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
          },
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 3,
            shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
            child: Container(
              width: width / 1.4,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromRGBO(101, 101, 101, 0.6)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Delete Service",
                style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(101, 101, 101, 1),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ));
  }

  void suggestionSeeker(String value) {
    if (value.isNotEmpty) {
      suggestions.clear();
      serviceCategoryList.getServicesList.forEach((element) {
        if (element.toUpperCase().startsWith(value.toUpperCase())) {
          suggestions.add(element);
        }
      });
      if (suggestions.isNotEmpty) {
        suggestionFlag = false;
      } else {
        suggestionFlag = true;
      }
      print(suggestions);
    } else {
      suggestionFlag = true;
      suggestions.clear();
    }
    setState(() {});
  }
}
