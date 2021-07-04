import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/UI/AllPages/Notifications.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/ClientInfo.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/ClientReviews.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class SelectedClientProfile extends StatefulWidget {
  final String contractID, clientID;
  SelectedClientProfile(this.contractID, this.clientID);

  @override
  State<StatefulWidget> createState() => SelectedClientProfileState();
}

class SelectedClientProfileState extends State<SelectedClientProfile>
    with SingleTickerProviderStateMixin {
  double width, height;
  TabController tabController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  final blocClientInfo = new MyworkBloc();
  final blocClientReviews = new MyworkBloc();

  @override
  void initState() {
    blocClientInfo.add(getWorkerDetails(widget.contractID));
    blocClientReviews.add(getWorkerReviews(widget.clientID));
    tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text("Client Profile"),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notifications()));
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
                            "Information",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tabController.animateTo(1);
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
          children: [
            BlocProvider(
              create: (context) => blocClientInfo,
              child: ClientInfo(),
            ),
            BlocProvider(
              create: (context) => blocClientReviews,
              child: ClientReviews(),
            ),
          ],
        ),
      ),
    );
  }
}
