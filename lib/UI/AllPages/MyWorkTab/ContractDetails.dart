import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/CancelContract.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/ReportContract.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/SendInvoice.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class ContractDetails extends StatefulWidget {
  final bool activeWork;
  final String contractID, clientID;
  ContractDetails(this.contractID, this.clientID, this.activeWork);

  @override
  State<StatefulWidget> createState() => ContractDetailsState();
}

class ContractDetailsState extends State<ContractDetails> {
  double width, height;
  final blocReview = new MyworkBloc();
  @override
  void initState() {
    super.initState();
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
            if (!widget.activeWork && state.response['status'] == "Completed") {
              blocReview.add(getSelectedClientReview(widget.contractID));
            }
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
              return displayScreeen(state.response, state.code);
            }
          },
        ),
      ),
    );
  }

  Widget displayScreeen(response, int code) {
    return code != 200
        ? SomethingWentWrong()
        : SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Type",
                          style: TextStyle(
                              color: Color.fromRGBO(39, 39, 39, 1),
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          response['service_category'],
                          style: TextStyle(
                              color: Color.fromRGBO(13, 106, 106, 1),
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(112, 112, 112, 0.11),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Time & Address",
                          style: TextStyle(
                              color: Color.fromRGBO(39, 39, 39, 1),
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Color.fromRGBO(13, 106, 106, 1),
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "${DateFormat.MMMd().format(DateFormat("yyyy-MM-dd").parse(response['date_selected']))},  ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(response['starttime_selected']))}",
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1),
                                    fontSize: 15)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Color.fromRGBO(13, 106, 106, 1),
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(response['address'],
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1),
                                    fontSize: 15)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work_outline,
                              color: Color.fromRGBO(13, 106, 106, 1),
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(response['work_size'],
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1),
                                    fontSize: 15)),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: Color.fromRGBO(13, 106, 106, 1),
                              size: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                response['vehicle_required'] == false
                                    ? "No Vehicle needed for this Service"
                                    : response['vehicle_type'],
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1),
                                    fontSize: 15)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          color: Color.fromRGBO(112, 112, 112, 0.11),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Work Description",
                          style: TextStyle(
                              color: Color.fromRGBO(39, 39, 39, 1),
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(response['work_desc'],
                            style: TextStyle(
                                color: Color.fromRGBO(101, 101, 101, 1),
                                fontSize: 15)),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: widget.activeWork,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Material(
                              elevation: 3,
                              shadowColor: Color.fromRGBO(129, 187, 46, 0.39),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Color.fromRGBO(129, 187, 46, 1),
                              child: FlatButton(
                                height: 40,
                                minWidth: width / 1.4,
                                color: Color.fromRGBO(129, 187, 46, 1),
                                textColor: Colors.white,
                                child: Text(
                                  "Send Invoice",
                                  style: TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SendInvoice(
                                              widget.contractID,
                                              widget.clientID)));
                                },
                              )),
                        ),
                        Container(
                            width: width / 1.4,
                            height: 48,
                            margin: EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CancelContract(widget.contractID)));
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
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(101, 101, 101, 0.6)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Cancel Contract",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(101, 101, 101, 1),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReportContract(widget.contractID)));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flag_sharp,
                                  color: Color.fromRGBO(129, 187, 46, 1),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Report This Contract",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(129, 187, 46, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                response['status'] == "Completed"
                    ? Visibility(
                        visible: !widget.activeWork,
                        child: BlocBuilder(
                          bloc: blocReview,
                          builder: (context, state) {
                            if (state is MyworkInitial ||
                                state is MyworkLoading) {
                              return Container();
                            } else if (state is MyworkLoadedwithResponse) {
                              return reviewScreen(state.response, state.code);
                            }
                          },
                        ))
                    : response['status'] == "Cancelled"
                        ? Container(
                            width: width,
                            child: Card(
                              elevation: 3,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Contract was cancelled!",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        : response['status'] == "Reported"
                            ? Container(
                                width: width,
                                child: Card(
                                  elevation: 3,
                                  margin: EdgeInsets.all(10),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Contract was reported!",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            : Container()
              ],
            ),
          );
  }

  Widget reviewScreen(response, int code) {
    return code != 200
        ? SomethingWentWrong()
        : response == null
            ? Container()
            : Card(
                elevation: 3,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Review",
                        style: TextStyle(
                          color: Color.fromRGBO(39, 39, 39, 1),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        response['worker_name'],
                        style: TextStyle(
                            color: Color.fromRGBO(39, 39, 39, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_border_outlined,
                              color: Color.fromRGBO(249, 175, 25, 1)),
                          Visibility(
                              visible:
                                  int.parse(response['rating'].toString()) > 1,
                              child: Icon(Icons.star_border_outlined,
                                  color: Color.fromRGBO(249, 175, 25, 1))),
                          Visibility(
                              visible:
                                  int.parse(response['rating'].toString()) > 2,
                              child: Icon(Icons.star_border_outlined,
                                  color: Color.fromRGBO(249, 175, 25, 1))),
                          Visibility(
                              visible:
                                  int.parse(response['rating'].toString()) > 3,
                              child: Icon(Icons.star_border_outlined,
                                  color: Color.fromRGBO(249, 175, 25, 1))),
                          Visibility(
                              visible:
                                  int.parse(response['rating'].toString()) > 4,
                              child: Icon(Icons.star_border_outlined,
                                  color: Color.fromRGBO(249, 175, 25, 1))),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("\"${response['text']}\"",
                          style: TextStyle(
                              color: Color.fromRGBO(101, 101, 101, 1),
                              fontSize: 12))
                    ],
                  ),
                ),
              );
  }
}
