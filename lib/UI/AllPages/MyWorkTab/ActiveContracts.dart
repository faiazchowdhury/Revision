import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';
import 'package:revised_quickassist/Model/activeContracts.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/SelectedClientProfile.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/SelectedContract.dart';

class ActiveContracts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActiveContractsState();
}

class ActiveContractsState extends State<ActiveContracts> {
  double width, height;
  final bloc = new MyworkBloc();

  @override
  void initState() {
    if (activeContracts.getResponse == null) {
      bloc.add(getActiveWork());
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
        if (state is MyworkLoading) {
          return LoaderSmallerCircular();
        } else if (state is MyworkInitial || state is MyworkLoaded) {
          return displayScreen();
        } else {
          return Container();
        }
      },
    );
  }

  Widget displayScreen() {
    var response = activeContracts.getResponse;
    return activeContracts.getCode != 200
        ? SomethingWentWrong()
        : response.length == 0
            ? Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "No Active Works!",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(13, 106, 106, 0.29)),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: response.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(children: [
                    Container(
                        width: width,
                        height: 110,
                        child: Card(
                            elevation: 2,
                            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        pushNewScreen(context,
                                            screen: SelectedClientProfile(
                                                response[response.length -
                                                        index -
                                                        1]['id']
                                                    .toString(),
                                                response[response.length -
                                                        index -
                                                        1]['client']
                                                    .toString()),
                                            withNavBar: false);
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 0, 5),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Center(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2000),
                                                    child: Image.network(
                                                      "${baseUrl.getpicUrl}${response[response.length - index - 1]['client_picture']}",
                                                      width: 65,
                                                      height: 65,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Center(
                                                    child: Text(
                                                        response[response
                                                                .length -
                                                            index -
                                                            1]['client_name'],
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    129,
                                                                    187,
                                                                    46,
                                                                    1)))))
                                          ],
                                        ),
                                      ),
                                    )),
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
                                                response[response.length -
                                                    index -
                                                    1]['service_category'],
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromRGBO(
                                                        32, 32, 32, 1)),
                                              ),
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Color.fromRGBO(
                                                        13, 106, 106, 1),
                                                    size: 12),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    response[response.length -
                                                        index -
                                                        1]['date_selected'],
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1)))
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(response[response.length - index - 1]['starttime_selected']))} - ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(response[response.length - index - 1]['endtime_selected']))}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1)))
                                              ],
                                            )),
                                            Expanded(
                                                child: Row(
                                              children: [
                                                Icon(
                                                  Icons.work_outline,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    response[response.length -
                                                        index -
                                                        1]['work_size'],
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Color.fromRGBO(
                                                            101, 101, 101, 1)))
                                              ],
                                            )),
                                          ],
                                        ))),
                                Expanded(
                                    flex: 3,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (response[response.length -
                                                index -
                                                1]['seen_by_worker'] ==
                                            false) {
                                          bloc.add(markContractAsCompleted(
                                              response[response.length -
                                                      index -
                                                      1]['id']
                                                  .toString()));
                                        }
                                        await pushNewScreen(context,
                                            screen: SelectedContract(
                                                response[response.length -
                                                        index -
                                                        1]['id']
                                                    .toString(),
                                                response[response.length -
                                                        index -
                                                        1]['client']
                                                    .toString(),
                                                true),
                                            withNavBar: false);
                                        setState(() {});
                                      },
                                      child: Container(
                                          height: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(13, 106, 106, 1),
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(5)),
                                          ),
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          )),
                                    ))
                              ],
                            ))),
                    Visibility(
                        visible: !response[response.length - index - 1]
                            ['seen_by_worker'],
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(249, 175, 25, 1),
                            border: Border.all(
                              color: Color.fromRGBO(249, 175, 25, 1),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "New",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ))
                  ]);
                });
  }
}
