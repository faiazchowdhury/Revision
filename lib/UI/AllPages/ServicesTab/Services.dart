import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:revised_quickassist/Model/serviceProviderLoaction.dart';
import 'package:revised_quickassist/Model/apiKey.dart';
import 'package:revised_quickassist/UI/AllPages/Notifications.dart';
import 'package:revised_quickassist/UI/AllPages/ServicesTab/AllServicesList.dart';
import 'package:revised_quickassist/UI/AllPages/ServicesTab/Reviews.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/services_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Services extends StatefulWidget {
  final int initialIndex;
  Services(this.initialIndex);

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends State<Services>
    with SingleTickerProviderStateMixin {
  double width, height;
  TabController tabController;
  double lat = 40.735192, long = -74.171968, radius = 1000;
  bool searchLocationDropDown = true;
  String searchLocationHint = "Search your location", token = "";
  GoogleMapController gController;
  String error = "";
  List<String> locationList = [];
  ConnectionState locationConnection = ConnectionState.active;
  final List<Circle> circleArea = [];
  final bloc = new ServicesBloc();
  final saveButtonBloc = new ServicesBloc();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void initState() {
    tabController = new TabController(
        initialIndex: widget.initialIndex, length: 3, vsync: this);
    if (serviceProviderLoaction.getResponse == null) {
      bloc.add(getServiceProviderLocation());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
              centerTitle: true,
              leading: Container(),
              title: Text("My Services"),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()));
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(20),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset("assets/notification.svg")),
                  ),
                ),
              ],
              backgroundColor: Color.fromRGBO(13, 106, 106, 1),
              elevation: 2,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: ColoredBox(
                    color: Colors.white,
                    child: TabBar(
                      controller: tabController,
                      labelPadding: EdgeInsets.only(top: 6, bottom: 6),
                      indicatorColor: Color(0xFF0D6A5A),
                      labelColor: Color(0xFF0D6A5A),
                      unselectedLabelColor: Color(0xFF656565),
                      indicatorWeight: 3,
                      tabs: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tabController.animateTo(0);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 7, bottom: 7),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: Colors.black.withOpacity(0.2),
                                        width: 0.5,
                                        style: BorderStyle.solid))),
                            child: Text(
                              "Services",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print(serviceProviderLoaction.getResponse);
                            if (serviceProviderLoaction.getResponse == null) {
                              bloc.add(getServiceProviderLocation());
                            } else {
                              if (serviceProviderLoaction
                                      .getResponse['radius'] !=
                                  null) {
                                lat = double.parse(serviceProviderLoaction
                                    .getResponse['lattitude']);
                                long = double.parse(serviceProviderLoaction
                                    .getResponse['longtitude']);
                                searchLocationHint = serviceProviderLoaction
                                    .getResponse['name']
                                    .toString();
                                radius = double.parse(serviceProviderLoaction
                                        .getResponse['radius']) *
                                    1000;
                              } else {
                                lat = 40.735192;
                                long = -74.171968;
                                radius = 0;
                              }
                            }
                            setState(() {
                              tabController.animateTo(1);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 7, bottom: 7),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: Colors.black.withOpacity(0.2),
                                        width: 0.5,
                                        style: BorderStyle.solid),
                                    left: BorderSide(
                                        color: Colors.black.withOpacity(0.2),
                                        width: 0.5,
                                        style: BorderStyle.solid))),
                            child: Text(
                              "Location",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tabController.animateTo(2);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 7, bottom: 7),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.black.withOpacity(0.2),
                                        width: 0.5,
                                        style: BorderStyle.solid))),
                            child: Text(
                              "Reviews",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [AllServicesList(this), location(), Reviews(this)],
          ),
        ));
  }

  Widget location() {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => bloc,
          ),
          BlocProvider(
            create: (BuildContext context) => saveButtonBloc,
          ),
        ],
        child: BlocListener(
          bloc: bloc,
          listener: (context, state) {
            if (state is ServicesLoaded) {
              if (serviceProviderLoaction.getResponse['radius'] != null) {
                lat = double.parse(
                    serviceProviderLoaction.getResponse['lattitude']);
                long = double.parse(
                    serviceProviderLoaction.getResponse['longtitude']);
                searchLocationHint =
                    serviceProviderLoaction.getResponse['name'].toString();
                radius = double.parse(
                        serviceProviderLoaction.getResponse['radius']) *
                    1000;
              } else {
                lat = 40.735192;
                long = -74.171968;
                radius = 0;
              }
            }
          },
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is ServicesInitial) {
                return displayScreen();
              } else if (state is ServicesLoading) {
                return LoaderSmallerCircular();
              } else if (state is ServicesLoaded) {
                return displayScreen();
              }
            },
          ),
        ));
  }

  Widget displayScreen() {
    var res = serviceProviderLoaction.getResponse;
    print(res);
    return serviceProviderLoaction.getCode != 200
        ? SomethingWentWrong()
        : SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                width: width - 100,
                child: Text(
                  "Your Location",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    searchLocationDropDown = !searchLocationDropDown;
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
                    width: width - 100,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 49,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          searchLocationHint,
                          style: TextStyle(
                              color: Color.fromRGBO(32, 32, 32, 1),
                              fontSize: 15),
                        )),
                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              searchLocationDropDown
                                  ? Icons.keyboard_arrow_down_outlined
                                  : Icons.keyboard_arrow_up_outlined,
                              color: Color.fromRGBO(13, 106, 106, 1),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(117, 117, 117, 0.7)),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Color.fromRGBO(247, 247, 247, 1),
                ),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: searchLocationDropDown ? 0 : 200,
                width: searchLocationDropDown ? 0 : width - 100,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child: TextField(
                            onChanged: (value) =>
                                autoCompleteMapLocation(value),
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
                        child: locationConnection == ConnectionState.waiting
                            ? LoaderSmallerCircular()
                            : Scrollbar(
                                thickness: 3,
                                child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Divider(
                                              endIndent: 10,
                                              indent: 10,
                                              height: 1,
                                              thickness: 1,
                                              color: Color.fromRGBO(
                                                  101, 101, 101, 0.2),
                                            ),
                                    itemCount: locationList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(locationList[index],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    101, 101, 101, 1),
                                                fontSize: 15)),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        onTap: () {
                                          setState(() {
                                            searchLocationDropDown = true;
                                            searchLocationHint =
                                                locationList[index];
                                            searchLocationButtonClick(
                                                searchLocationHint);
                                          });
                                        },
                                      );
                                    }),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                width: width - 100,
                child: Text(
                  "Your Service Range",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              Container(
                width: width - 100,
                child: Row(
                  children: [
                    Container(
                        width: width - 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Material(
                          elevation: 1,
                          child: TextFormField(
                            initialValue: (radius / 1609.34).toStringAsFixed(2),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  radius = 0;
                                });
                              } else {
                                print(1);
                                setState(() {
                                  radius = double.parse(value) * 1609.34;
                                });
                              }
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                            ],
                            keyboardType: TextInputType.number,
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
                                    color: Color.fromRGBO(117, 117, 117, 0.5),
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(117, 117, 117, 0.5),
                                  )),
                            ),
                          ),
                        )),
                    Text(
                      "  - Miles",
                      style: TextStyle(
                          color: Color.fromRGBO(32, 32, 32, 1), fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              googoleMap(res),
              SizedBox(
                height: 10,
              ),
              ErrorMessage(error),
              BlocListener(
                bloc: saveButtonBloc,
                listener: (context, state) {
                  if (state is ServicesLoadedwithResponse) {
                    error = "";
                    if (state.code != 200) {
                      snackbar(scaffoldKey,
                              "Couldn't save location! Please try again")
                          .showSnackbar();
                    } else {
                      snackbar(scaffoldKey, "Location saved successfully!")
                          .showSnackbar();
                    }
                    setState(() {});
                  }
                },
                child: BlocBuilder(
                  bloc: saveButtonBloc,
                  builder: (context, state) {
                    if (state is ServicesInitial) {
                      return saveButton();
                    }
                    if (state is ServicesLoading) {
                      return loadingCircle();
                    }
                    if (state is ServicesLoadedwithResponse) {
                      return saveButton();
                    }
                  },
                ),
              )
            ],
          ));
  }

  googoleMap(res) {
    return Container(
        width: width - 100,
        height: height / 2.5,
        child: GoogleMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet(),
          markers: Set.from([
            Marker(
                position: LatLng(lat = lat, long = long),
                markerId: MarkerId('Initial'))
          ]),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            setState(() {
              gController = controller;
            });
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(lat, long), zoom: 10),
          circles: Set.from([
            Circle(
              circleId: CircleId("id"),
              strokeWidth: 1,
              strokeColor: Colors.black12,
              fillColor: Color.fromRGBO(13, 106, 106, 0.3),
              center: LatLng(lat, long),
              radius: radius,
            )
          ]),
        ));
  }

  void autoCompleteMapLocation(String value) async {
    if (value.length > 1) {
      setState(() {
        locationConnection = ConnectionState.waiting;
      });
      List<String> autoCompleteList = [];
      if (token == "") {
        Uuid tokenId = new Uuid();
        setState(() {
          token = tokenId.v4();
        });
      }
      var res = await http.get(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$value&key=${apiKey.getGKey}&sessiontoken=$token&components=country:US");
      if (res.statusCode == 200) {
        var next = json.decode(res.body);
        for (int i = 0; i < next['predictions'].length; i++) {
          for (int j = 0; j < next['predictions'][i]['terms'].length; j++) {
            String temp = next['predictions'][i]['terms'][j]['value']
                .toString()
                .toUpperCase();
            if (temp == "NEWARK" ||
                temp == "EDISON" ||
                temp == "MORRISTOWN" ||
                temp == "PARAMUS" ||
                temp == "STATEN ISLAND" ||
                temp == "MANHATTAN" ||
                temp == "BRONX" ||
                temp == "QUEENS" ||
                temp == "NEW YORK" ||
                temp == "HOBOKEN" ||
                temp == "FORT LEE" ||
                temp == "BAYONNE" ||
                temp == "CLIFTON" ||
                temp == "UNION" ||
                temp == "YONKERS" ||
                temp == "PERTH AMBOY" ||
                temp == "EAST BRUNSWICK" ||
                temp == "JERSEY CITY" ||
                temp == "BROOKLYN") {
              if (next['predictions'][i]['terms'][j + 1]['value'] == "NJ" ||
                  next['predictions'][i]['terms'][j + 1]['value'] == "NY") {
                if (autoCompleteList.isEmpty) {
                  autoCompleteList = [
                    next['predictions'][i]['description'].toString()
                  ];
                } else {
                  autoCompleteList
                      .add(next['predictions'][i]['description'].toString());
                }
              }
              break;
            }
          }
        }
        setState(() {
          print(autoCompleteList);
          locationList = autoCompleteList;
          locationConnection = ConnectionState.done;
        });
      } else {
        setState(() {
          locationList = autoCompleteList;
          locationConnection = ConnectionState.none;
        });
      }
    }
  }

  searchLocationButtonClick(String string) async {
    try {
      var addresses = await Geocoder.google("${apiKey.getGKey}")
          .findAddressesFromQuery(string);
      print(addresses);
      var first = addresses.first;
      setState(() {
        lat = first.coordinates.latitude;
        long = first.coordinates.longitude;
        gController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, long), zoom: 10)));
      });
    } catch (e) {
      setState(() {});
    }
  }

  Widget saveButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 30),
      alignment: Alignment.bottomCenter,
      child: Material(
          elevation: 3,
          shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color.fromRGBO(139, 187, 46, 1),
          child: FlatButton(
            height: 40,
            minWidth: 295,
            color: Color.fromRGBO(139, 187, 46, 1),
            textColor: Colors.white,
            child: Text(
              "Save",
            ),
            onPressed: () async {
              if (radius > (50 * 1609.34)) {
                setState(() {
                  error = "Range cannot be more than 50 miles!";
                });
              } else {
                if (radius == 0) {
                  setState(() {
                    error = "Range needs to be be more than 0 miles!";
                  });
                } else {
                  if (searchLocationHint == "Search your location") {
                    setState(() {
                      error = "Need to select a location to continue!";
                    });
                  } else {
                    setState(() {
                      token = "";
                    });
                    saveButtonBloc.add(saveServiceProviderLocation(
                        lat, long, radius / 1000, searchLocationHint));
                  }
                }
              }
            },
          )),
    );
  }
}
