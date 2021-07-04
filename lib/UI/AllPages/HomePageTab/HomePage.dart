import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';
import 'package:revised_quickassist/UI/AllPages/TabSelector.dart';

import '../Notifications.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    serviceProviderInfo.setVisible = !serviceProviderInfo.availability ||
        !serviceProviderInfo.service ||
        !serviceProviderInfo.location;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leadingWidth: 0,
          leading: Container(),
          actions: [
            Container(
              padding: EdgeInsets.all(20),
              child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()));
                    },
                    child: SvgPicture.asset("assets/notification.svg"),
                  )),
            )
          ],
          centerTitle: false,
          title: FittedBox(
            child: Text(
              serviceProviderInfo.visible == true
                  ? "Hi ${serviceProviderInfo.name},\nLet's get started by\norganizing your account"
                  : "Hi ${serviceProviderInfo.name},\nLet's check today's schedule",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ),
          toolbarHeight:
              serviceProviderInfo.visible == false ? ((130 * 2) / 3) + 10 : 130,
          backgroundColor: Color.fromRGBO(13, 106, 106, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          )),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                  visible: serviceProviderInfo.visible,
                  child: Column(
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          elevation: 3,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  flex: 0,
                                  child: serviceProviderInfo.visible == false
                                      ? Container()
                                      : serviceProviderInfo.service == false
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.adjust_outlined,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 12,
                                                )
                                              ],
                                            )
                                          : Icon(
                                              Icons.check_circle,
                                              color: Color.fromRGBO(
                                                  13, 106, 106, 1),
                                              size: 20,
                                            )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Add Services",
                                    style: TextStyle(
                                        color: Color.fromRGBO(32, 32, 32, 1),
                                        fontSize: 15),
                                  )),
                              Expanded(
                                  flex: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  TabSelector(false, 3, 0)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(8))),
                                      padding: EdgeInsets.all(20),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          elevation: 3,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  flex: 0,
                                  child: serviceProviderInfo.visible == false
                                      ? Container()
                                      : serviceProviderInfo.availability ==
                                              false
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.adjust_outlined,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 12,
                                                )
                                              ],
                                            )
                                          : Icon(
                                              Icons.check_circle,
                                              color: Color.fromRGBO(
                                                  13, 106, 106, 1),
                                              size: 20,
                                            )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Set Availability",
                                    style: TextStyle(
                                        color: Color.fromRGBO(32, 32, 32, 1),
                                        fontSize: 15),
                                  )),
                              Expanded(
                                  flex: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabSelector(false, 2, 0)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(8))),
                                      padding: EdgeInsets.all(20),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          elevation: 3,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  flex: 0,
                                  child: serviceProviderInfo.visible == false
                                      ? Container()
                                      : serviceProviderInfo.location == false
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Icon(
                                                  Icons.adjust_outlined,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  color: Colors.white,
                                                  size: 12,
                                                )
                                              ],
                                            )
                                          : Icon(
                                              Icons.check_circle,
                                              color: Color.fromRGBO(
                                                  13, 106, 106, 1),
                                              size: 20,
                                            )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Locate Service Area",
                                    style: TextStyle(
                                        color: Color.fromRGBO(32, 32, 32, 1),
                                        fontSize: 15),
                                  )),
                              Expanded(
                                  flex: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabSelector(false, 3, 1)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(8))),
                                      padding: EdgeInsets.all(20),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              serviceProviderInfo.visible == true ||
                      serviceProviderInfo.noWork == true
                  ? SizedBox(
                      width: width,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.all(10),
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today's Schedule",
                                  style: TextStyle(
                                      color: Color.fromRGBO(101, 101, 101, 1),
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SvgPicture.asset(
                                      "assets/calendar (2).svg"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    "No Schedule Yet!",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(13, 106, 106, 0.29),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )),
                    )
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          serviceProviderInfo.tScheduleType.length == 0
                              ? SizedBox(
                                  width: width,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(10),
                                      elevation: 3,
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Today's Schedule",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      101, 101, 101, 1),
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: SvgPicture.asset(
                                                  "assets/calendar (2).svg"),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: Text(
                                                "No Schedule Yet!",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        13, 106, 106, 0.29),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      )),
                                )
                              : Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(10),
                                  elevation: 3,
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Today's Schedule",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  101, 101, 101, 1),
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          height: 2,
                                          color: Color.fromRGBO(
                                              112, 112, 112, 0.3),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                height: 1,
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 0.3),
                                              );
                                            },
                                            itemCount: serviceProviderInfo
                                                .tScheduleType.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  Container(
                                                    width: 5,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            13, 106, 106, 1),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8))),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        serviceProviderInfo
                                                                .tScheduleType[
                                                            index],
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    13,
                                                                    106,
                                                                    106,
                                                                    1),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.access_time,
                                                            color:
                                                                Color.fromRGBO(
                                                                    13,
                                                                    106,
                                                                    106,
                                                                    1),
                                                            size: 13,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            serviceProviderInfo
                                                                    .tScheduleTime[
                                                                index],
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        101,
                                                                        101,
                                                                        101,
                                                                        1),
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                  ))
                        ],
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              serviceProviderInfo.nScheduleDate.length == 0
                  ? Visibility(
                      visible: !serviceProviderInfo.visible,
                      child: SizedBox(
                        width: width,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(10),
                            elevation: 3,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Upcoming",
                                    style: TextStyle(
                                        color: Color.fromRGBO(101, 101, 101, 1),
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: SvgPicture.asset(
                                        "assets/calendar (2).svg"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "No Schedule Yet!",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              13, 106, 106, 0.29),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(10),
                      elevation: 3,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upcoming",
                              style: TextStyle(
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 2,
                              color: Color.fromRGBO(112, 112, 112, 0.3),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 1,
                                    color: Color.fromRGBO(112, 112, 112, 0.3),
                                  );
                                },
                                itemCount:
                                    serviceProviderInfo.nScheduleDate.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(13, 106, 106, 1),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(8))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            serviceProviderInfo
                                                .nScheduleType[index],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                size: 13,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                serviceProviderInfo
                                                    .nScheduleDate[index],
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        101, 101, 101, 1),
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.access_time,
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                size: 13,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                serviceProviderInfo
                                                    .nScheduleTime[index],
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        101, 101, 101, 1),
                                                    fontSize: 12),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
