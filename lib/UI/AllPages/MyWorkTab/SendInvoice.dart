import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/Model/listOfInfo.dart';
import 'package:revised_quickassist/UI/AllPages/MyWorkTab/ReviewClient.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class SendInvoice extends StatefulWidget {
  final String contractID, clientID;
  SendInvoice(this.contractID, this.clientID);

  @override
  State<StatefulWidget> createState() => SendInvoiceState();
}

class SendInvoiceState extends State<SendInvoice> {
  double width, height;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  bool selectedDropdownInvoiceHour = true, selectedDropdownInvoiceMinute = true;
  String hintInvoiceHour = "Hour", hintInvoiceMinute = "Minute", error = "";
  final bloc = new MyworkBloc();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AllPagesAppBar.appBar(context, true, false, "Invoice"),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Card(
            elevation: 2,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SvgPicture.asset("assets/bill.svg"),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Invoice Details",
                    style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Please enter your hour preciously, this will get to the client and you will get your payment after client confirm it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: width / 4,
                              child: Text(
                                "Hour",
                                style: TextStyle(
                                    color: Color.fromRGBO(101, 101, 101, 1),
                                    fontSize: 10),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDropdownInvoiceHour =
                                      !selectedDropdownInvoiceHour;
                                });
                              },
                              child: Center(
                                child: AnimatedContainer(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(117, 117, 117, 0.7)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    color: Color.fromRGBO(247, 247, 247, 1),
                                  ),
                                  width: width / 4,
                                  height: selectedDropdownInvoiceHour
                                      ? 52.0
                                      : 250.0,
                                  duration: Duration(milliseconds: 0),
                                  curve: Curves.fastOutSlowIn,
                                  child: selectedDropdownInvoiceHour
                                      ?
                                      //Menu not clicked hence Collapsed
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  fit: FlexFit.tight,
                                                  flex: 1,
                                                  child: Text(
                                                    hintInvoiceHour,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            32, 32, 32, 1),
                                                        fontSize: 15),
                                                  )),
                                              Flexible(
                                                flex: 0,
                                                fit: FlexFit.tight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Icon(
                                                    selectedDropdownInvoiceHour
                                                        ? Icons
                                                            .keyboard_arrow_down_outlined
                                                        : Icons
                                                            .keyboard_arrow_up_outlined,
                                                    color: Color.fromRGBO(
                                                        13, 106, 106, 1),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      :
                                      //Menu clicked hence Expanded
                                      Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                        fit: FlexFit.tight,
                                                        flex: 1,
                                                        child: Text(
                                                          hintInvoiceHour,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      32,
                                                                      32,
                                                                      32,
                                                                      1),
                                                              fontSize: 15),
                                                        )),
                                                    Flexible(
                                                      flex: 0,
                                                      fit: FlexFit.tight,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Icon(
                                                            selectedDropdownInvoiceHour
                                                                ? Icons
                                                                    .keyboard_arrow_down_outlined
                                                                : Icons
                                                                    .keyboard_arrow_up_outlined,
                                                            color:
                                                                Color.fromRGBO(
                                                                    13,
                                                                    106,
                                                                    106,
                                                                    1)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 0,
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      5, 0, 5, 0),
                                                  height: 1.0,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                )),
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: ListView.separated(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Divider(
                                                              endIndent: 10,
                                                              indent: 10,
                                                              height: 1,
                                                              thickness: 1,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      101,
                                                                      101,
                                                                      101,
                                                                      0.2),
                                                            ),
                                                    itemCount: listOfInfo
                                                        .amountOfTimeHours
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return ListTile(
                                                        title: Text(
                                                            listOfInfo
                                                                    .amountOfTimeHours[
                                                                index],
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        101,
                                                                        101,
                                                                        101,
                                                                        1),
                                                                fontSize: 15)),
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 0, 0),
                                                        onTap: () {
                                                          setState(() {
                                                            selectedDropdownInvoiceHour =
                                                                true;
                                                            hintInvoiceHour =
                                                                listOfInfo
                                                                        .amountOfTimeHours[
                                                                    index];
                                                          });
                                                        },
                                                      );
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width / 4,
                            child: Text(
                              "Minute",
                              style: TextStyle(
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                  fontSize: 10),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDropdownInvoiceMinute =
                                    !selectedDropdownInvoiceMinute;
                              });
                            },
                            child: Center(
                              child: AnimatedContainer(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(117, 117, 117, 0.7)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: Color.fromRGBO(247, 247, 247, 1),
                                ),
                                width: width / 4,
                                height: selectedDropdownInvoiceMinute
                                    ? 52.0
                                    : 250.0,
                                duration: Duration(milliseconds: 0),
                                curve: Curves.fastOutSlowIn,
                                child: selectedDropdownInvoiceMinute
                                    ?
                                    //Menu not clicked hence Collapsed
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                                fit: FlexFit.tight,
                                                flex: 1,
                                                child: Text(
                                                  hintInvoiceMinute,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          32, 32, 32, 1),
                                                      fontSize: 15),
                                                )),
                                            Flexible(
                                              flex: 0,
                                              fit: FlexFit.tight,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  selectedDropdownInvoiceMinute
                                                      ? Icons
                                                          .keyboard_arrow_down_outlined
                                                      : Icons
                                                          .keyboard_arrow_up_outlined,
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    :
                                    //Menu clicked hence Expanded
                                    Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                      fit: FlexFit.tight,
                                                      flex: 1,
                                                      child: Text(
                                                        hintInvoiceMinute,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    32,
                                                                    32,
                                                                    32,
                                                                    1),
                                                            fontSize: 15),
                                                      )),
                                                  Flexible(
                                                    flex: 0,
                                                    fit: FlexFit.tight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Icon(
                                                          selectedDropdownInvoiceMinute
                                                              ? Icons
                                                                  .keyboard_arrow_down_outlined
                                                              : Icons
                                                                  .keyboard_arrow_up_outlined,
                                                          color: Color.fromRGBO(
                                                              13, 106, 106, 1)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 0,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    5, 0, 5, 0),
                                                height: 1.0,
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                              )),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          Divider(
                                                            endIndent: 10,
                                                            indent: 10,
                                                            height: 1,
                                                            thickness: 1,
                                                            color:
                                                                Color.fromRGBO(
                                                                    101,
                                                                    101,
                                                                    101,
                                                                    0.2),
                                                          ),
                                                  itemCount: listOfInfo
                                                      .amountOfTimeMinutes
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return ListTile(
                                                      title: Text(
                                                          listOfInfo
                                                                  .amountOfTimeMinutes[
                                                              index],
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      101,
                                                                      101,
                                                                      101,
                                                                      1),
                                                              fontSize: 15)),
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      onTap: () {
                                                        setState(() {
                                                          selectedDropdownInvoiceMinute =
                                                              true;
                                                          hintInvoiceMinute =
                                                              listOfInfo
                                                                      .amountOfTimeMinutes[
                                                                  index];
                                                        });
                                                      },
                                                    );
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ErrorMessage(error),
                  SizedBox(
                    height: 10,
                  ),
                  BlocProvider(
                    create: (context) => bloc,
                    child: BlocListener(
                      bloc: bloc,
                      listener: (context, state) {
                        if (state is MyworkLoadedwithResponse) {
                          if (state.code == 400) {
                            snackbar(scaffoldKey, "Invoice already sent")
                                .showSnackbar();
                          } else if (state.code != 200) {
                            snackbar(scaffoldKey,
                                    "Something went wrong! Please try again!")
                                .showSnackbar();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewClient(
                                        widget.contractID, widget.clientID)));
                          }
                        }
                      },
                      child: BlocBuilder(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is MyworkInitial ||
                              state is MyworkLoadedwithResponse) {
                            return continueButton();
                          } else if (state is MyworkLoading) {
                            return loadingCircle();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
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
              "Send Invoice",
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              if (hintInvoiceHour == "Hour" || hintInvoiceMinute == "Minute") {
                setState(() {
                  error = "Time must be provided!";
                });
              } else {
                setState(() {
                  error = "";
                });
                snackbar(scaffoldKey, "Processing...").showSnackbar();
                bloc.add(sendInvoice(
                    widget.contractID, hintInvoiceHour, hintInvoiceMinute));
              }
            },
          )),
    );
  }
}
