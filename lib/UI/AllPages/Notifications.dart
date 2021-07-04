import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/SelectedContract.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class Notifications extends StatefulWidget {
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  double width, newheight;
  final bloc = new ProfileBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(getNotification());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    newheight = height - padding.top - padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60,
        title: Text(
          "Notifications",
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
      body: SafeArea(
        child: Container(
            width: width,
            height: newheight,
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is ProfileInitial || state is ProfileLoading) {
                  return LoaderSmallerCircular();
                } else if (state is ProfileLoadedwithResponse) {
                  return displayScreen(state.response, state.code);
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }

  Widget displayScreen(response, int code) {
    print(response);
    return code != 200
        ? SomethingWentWrong()
        : response.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "You don't have any notification!",
                  style: TextStyle(
                      color: Color.fromRGBO(13, 106, 106, 0.29),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: response.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedContract(
                                response[index]['identifier'].toString(),
                                response[index]['worker'].toString(),
                                true),
                          ));
                    },
                    child: IntrinsicHeight(
                      child: Container(
                        width: width,
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Card(
                          elevation: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: SvgPicture.asset(
                                    "assets/notification.svg",
                                    color: Color.fromRGBO(13, 106, 106, 1),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  color: Color.fromRGBO(112, 112, 112, 0.15),
                                  width: 1,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        response[index]['text'].split('.')[0],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                13, 106, 106, 1)),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(response[index]['text'],
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  101, 101, 101, 1))),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: Color.fromRGBO(
                                                101, 101, 101, 1),
                                            size: 11,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Center(
                                            child: Text(
                                                "${DateFormat.jm().format(DateTime.parse(response[index]['creation_time'].toString()))}",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        139, 139, 139, 1))),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
  }
}
