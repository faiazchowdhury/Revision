import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:revised_quickassist/UI/AllPages/ServicesTab/Services.dart'
    as services;
import 'package:revised_quickassist/UI/AllPages/ServicesTab/AddOrEditServices.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/services_bloc.dart';
import 'package:revised_quickassist/Model/allServicesList.dart';

class AllServicesList extends StatefulWidget {
  final services.ServicesState servicesState;
  AllServicesList(this.servicesState);

  @override
  AllServicesListState createState() => AllServicesListState();
}

class AllServicesListState extends State<AllServicesList> {
  double width, height;
  final bloc = new ServicesBloc();

  @override
  void initState() {
    if (allServicesList.getResponse == null) {
      bloc.add(getServicesList());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ServicesInitial) {
          return displayList();
        } else if (state is ServicesLoading) {
          return LoaderSmallerCircular();
        } else if (state is ServicesLoaded) {
          return displayList();
        }
      },
    );
  }

  Widget displayList() {
    var res = allServicesList.getResponse;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 42,
          padding: EdgeInsets.only(left: 60, right: 60),
          child: Material(
            elevation: 2,
            shadowColor: Color.fromRGBO(129, 187, 46, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color.fromRGBO(139, 187, 46, 1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FlatButton(
                height: 40,
                minWidth: width - 120,
                color: Color.fromRGBO(139, 187, 46, 1),
                textColor: Colors.white,
                child: Text(
                  "+ Add Services",
                ),
                onPressed: () async {
                  await pushNewScreen(
                    context,
                    screen: AddOrEditServices(
                        true, 0, widget.servicesState.scaffoldKey),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  setState(() {});
                },
              ),
            ),
          )),
      body: Container(
        child: allServicesList.getCode != 200
            ? SomethingWentWrong()
            : res.length == 0
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "No Services Added yet!",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(13, 106, 106, 0.29)),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: res.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: res.length - 1 == index
                              ? EdgeInsets.only(bottom: 80)
                              : EdgeInsets.zero,
                          child: Container(
                              width: width - 60,
                              height: 100,
                              child: Card(
                                elevation: 2,
                                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Service Type",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          101, 101, 101, 1)),
                                                ),
                                              )),
                                              Expanded(
                                                  child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                          res[index]
                                                              ['service_name'],
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      32,
                                                                      32,
                                                                      32,
                                                                      1)))))
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 0, 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Hourly Rate",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1)),
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            res[index]['rate'],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        32,
                                                                        32,
                                                                        32,
                                                                        1)))))
                                              ],
                                            ))),
                                    Expanded(
                                        flex: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() async {
                                              await pushNewScreen(
                                                context,
                                                screen: AddOrEditServices(
                                                    false,
                                                    index,
                                                    widget.servicesState
                                                        .scaffoldKey),
                                                withNavBar:
                                                    false, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                              setState(() {});
                                              //count2 = 0;
                                              //response = snapshot.data;
                                              //ServiceSelectedtoEdit = index;
                                              //pages = "edit_services";
                                            });
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                        right:
                                                            Radius.circular(5)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: SvgPicture.asset(
                                                        "assets/edit.svg"),
                                                  )),
                                                  Expanded(
                                                      child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text("Edit",
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white))))
                                                ],
                                              )),
                                        ))
                                  ],
                                ),
                              )));
                    },
                  ),
      ),
    );
  }
}
