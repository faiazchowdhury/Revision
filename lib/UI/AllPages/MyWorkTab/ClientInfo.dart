import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class ClientInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClientInfoState();
}

class ClientInfoState extends State<ClientInfo> {
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return BlocProvider.value(
      value: BlocProvider.of<MyworkBloc>(context),
      child: BlocBuilder(
        bloc: BlocProvider.of<MyworkBloc>(context),
        builder: (context, state) {
          if (state is MyworkInitial) {
            return LoaderSmallerCircular();
          } else if (state is MyworkLoading) {
            return LoaderSmallerCircular();
          } else if (state is MyworkLoadedwithResponse) {
            return displayScreeen(state.response, state.code);
          }
        },
      ),
    );
  }

  Widget displayScreeen(response, int code) {
    return code != 200
        ? SomethingWentWrong()
        : SingleChildScrollView(
            child: Card(
            elevation: 3,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2))),
                      alignment: Alignment.center,
                      height: 150,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network(
                          "${baseUrl.getpicUrl}${response['profile_photo']}",
                          height: 150,
                          width: 150,
                        ),
                      ))),
                  SizedBox(
                    height: 20,
                  ),
                  Text(response['name'],
                      style: TextStyle(
                          color: Color.fromRGBO(13, 106, 106, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                    height: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Color.fromRGBO(39, 39, 39, 1),
                          ),
                          Text(
                            "   Joined From ",
                            style: TextStyle(
                                color: Color.fromRGBO(101, 101, 101, 1),
                                fontSize: 15),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            DateFormat.yMMMMd('en_US').format(
                                DateTime.parse(response['joined_from'])),
                            style: TextStyle(
                                color: Color.fromRGBO(39, 39, 39, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Color.fromRGBO(39, 39, 39, 1),
                          ),
                          Text(
                            "   Located At ",
                            style: TextStyle(
                                color: Color.fromRGBO(101, 101, 101, 1),
                                fontSize: 15),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(response['location'],
                            style: TextStyle(
                                color: Color.fromRGBO(39, 39, 39, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                    height: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About me",
                      style: TextStyle(
                          color: Color.fromRGBO(39, 39, 39, 1), fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      response['about_me'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(101, 101, 101, 1),
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ));
  }
}
