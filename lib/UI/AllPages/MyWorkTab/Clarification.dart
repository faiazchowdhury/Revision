import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class Clarification extends StatefulWidget {
  final String contractID;
  final bool activeWork;
  Clarification(this.contractID, this.activeWork);
  @override
  State<StatefulWidget> createState() => ClarificationState();
}

class ClarificationState extends State<Clarification> {
  double width, height;
  final bloc = new MyworkBloc();
  var response = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController chatController = new TextEditingController();

  void _onRefresh() async {
    bloc.add(getClarification(widget.contractID));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return BlocProvider.value(
      value: BlocProvider.of<MyworkBloc>(context),
      child: BlocListener(
        bloc: BlocProvider.of<MyworkBloc>(context),
        listener: (context, state) {
          if (state is MyworkLoadedwithResponse) {
            response = state.response;
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<MyworkBloc>(context),
          builder: (context, state) {
            if (state is MyworkInitial) {
              return LoaderSmallerCircular();
            } else if (state is MyworkLoading) {
              return LoaderSmallerCircular();
            } else if (state is MyworkLoadedwithResponse) {
              return displayScreen(state.code);
            }
          },
        ),
      ),
    );
  }

  Widget displayScreen(int code) {
    return code != 200
        ? SomethingWentWrong()
        : Container(
            width: width,
            height: height - 50,
            child: Stack(children: [
              response.length == 0
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "No texts to show!",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(13, 106, 106, 0.29)),
                        ),
                      ),
                    )
                  : BlocProvider(
                      create: (context) => bloc,
                      child: BlocListener(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state is MyworkLoadedwithResponse) {
                            response = state.response;
                          }
                        },
                        child: BlocBuilder(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is MyworkInitial) {
                              return conversationScreen();
                            } else if (state is MyworkLoading) {
                              return conversationScreen();
                            } else if (state is MyworkLoadedwithResponse) {
                              if (code == 200) {
                                _refreshController.refreshCompleted();
                              } else {
                                _refreshController.refreshFailed();
                              }
                              return conversationScreen();
                            }
                          },
                        ),
                      ),
                    ),
              widget.activeWork
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 12,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 10), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                          ),
                          width: width,
                          height: 70,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: chatController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    filled: true,
                                    fillColor: Color.fromRGBO(233, 233, 233, 1),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(101, 101, 101, 1),
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(101, 101, 101, 1),
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(101, 101, 101, 1),
                                        )),
                                    hintText: "Type your Comment Here...",
                                    hintStyle: TextStyle(
                                        color: Color.fromRGBO(32, 32, 32, 0.5),
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (chatController.text == "") {
                                      } else {
                                        bloc.add(postClarification(
                                            widget.contractID,
                                            chatController.text));
                                        setState(() {
                                          chatController.text = "";
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: 80,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "Send",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          )),
                    )
                  : Container(),
            ]));
  }

  Widget conversationScreen() {
    return Container(
      width: width,
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
              height: widget.activeWork
                  ? constraint.maxHeight - 70
                  : constraint.maxHeight,
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: Color.fromRGBO(129, 187, 46, 1),
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      reverse: true,
                      itemCount: response.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: IntrinsicHeight(
                            child: response[response.length - index - 1]
                                            ['user_type']
                                        .toString() ==
                                    "CLIENT"
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 0,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2000),
                                                  child: Image.network(
                                                    "${baseUrl.getpicUrl}${response[index]['client_profile_picture']}",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 10, 20, 10),
                                                    color: Color.fromRGBO(
                                                        243, 243, 243, 1),
                                                    child: Text(response[
                                                        response.length -
                                                            index -
                                                            1]['text']),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Container(
                                                    width: 15,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: Border.all(
                                                            color:
                                                                Color.fromRGBO(
                                                                    243,
                                                                    243,
                                                                    243,
                                                                    1),
                                                            width: 2)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8, top: 5),
                                                child: Text(
                                                  "${DateFormat().format(DateTime.parse(response[response.length - index - 1]['time']).toLocal())}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          131, 142, 154, 1),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: 40,
                                        )
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 8, 0),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 10, 20, 10),
                                                    color: Color.fromRGBO(
                                                        204, 238, 232, 1),
                                                    child: Text(response[
                                                        response.length -
                                                            index -
                                                            1]['text']),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          border: Border.all(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      204,
                                                                      238,
                                                                      232,
                                                                      1),
                                                              width: 2)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 8, top: 5),
                                                child: Text(
                                                  "${DateFormat().format(DateTime.parse(response[response.length - index - 1]['time']).toLocal())}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          131, 142, 154, 1),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                        Expanded(
                                          flex: 0,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2000),
                                                  child: Image.network(
                                                    "${baseUrl.getpicUrl}${response[index]['worker_profile_picture']}",
                                                    width: 45,
                                                    height: 45,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        );
                      })));
        },
      ),
    );
  }
}
