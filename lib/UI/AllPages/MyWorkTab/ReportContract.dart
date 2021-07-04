import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/Model/listOfInfo.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class ReportContract extends StatefulWidget {
  final String contractID;
  ReportContract(this.contractID);

  @override
  State<StatefulWidget> createState() => ReportContractState();
}

class ReportContractState extends State<ReportContract> {
  double width, height;
  bool reportListDropdown = true;
  String reportHint = "- Select from below", error = "";
  TextEditingController reportDetails = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  final bloc = new MyworkBloc();
  final buttonBloc = new MyworkBloc();

  @override
  void initState() {
    if (listOfInfo.reportList.isEmpty) {
      bloc.add(getReportList());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AllPagesAppBar.appBar(context, true, false, "Report Contract"),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => bloc,
            ),
            BlocProvider(
              create: (context) => buttonBloc,
            ),
          ],
          child: Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SvgPicture.asset("assets/flags.svg"),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Please let us know why do you think the contract is inappropriate?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Select Reason",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(101, 101, 101, 1)),
                            ),
                          ),
                          BlocBuilder(
                            bloc: bloc,
                            builder: (context, state) {
                              if (state is MyworkInitial ||
                                  state is MyworkLoaded) {
                                return reportListView();
                              } else if (state is MyworkLoading) {
                                return loadingCircle();
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ErrorMessage(error),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Text(
                              "Write a Review",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromRGBO(101, 101, 101, 1)),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(247, 247, 247, 1),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color.fromRGBO(117, 117, 117, 0.7)),
                              ),
                              height: 215,
                              child: TextFormField(
                                controller: reportDetails,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.transparent,
                                  )),
                                  hintText: "Write here...",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(32, 32, 32, 0.5),
                                      fontSize: 15),
                                ),
                              )),
                          SizedBox(
                            height: 35,
                          ),
                          BlocListener(
                            bloc: buttonBloc,
                            listener: (context, state) {
                              if (state is MyworkLoadedwithResponse) {
                                if (state.code != 200) {
                                  snackbar(scaffoldKey,
                                          "Something went wrong please try again!")
                                      .showSnackbar();
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: BlocBuilder(
                              bloc: buttonBloc,
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
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget reportListView() {
    return Center(
        child: GestureDetector(
      onTap: () {
        setState(() {
          reportListDropdown = !reportListDropdown;
        });
      },
      child: Center(
        child: AnimatedContainer(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(117, 117, 117, 0.7),
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromRGBO(247, 247, 247, 1),
          ),
          height: reportListDropdown ? 52.0 : 250.0,
          duration: Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
          child: reportListDropdown
              ?
              //Menu not clicked hence Collapsed
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 5,
                          child: Text(
                            reportHint,
                            style: TextStyle(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                fontSize: 15),
                          )),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Icon(
                          reportListDropdown
                              ? Icons.keyboard_arrow_down_outlined
                              : Icons.keyboard_arrow_up_outlined,
                          color: Color.fromRGBO(13, 106, 106, 1),
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
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 5,
                                child: Text(
                                  reportHint,
                                  style: TextStyle(
                                      color: Color.fromRGBO(32, 32, 32, 1),
                                      fontSize: 15),
                                )),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Icon(
                                  reportListDropdown
                                      ? Icons.keyboard_arrow_down_outlined
                                      : Icons.keyboard_arrow_up_outlined,
                                  color: Color.fromRGBO(13, 106, 106, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                          height: 1.0,
                          color: Color.fromRGBO(13, 106, 106, 1),
                          margin: EdgeInsets.only(left: 5.0, right: 10),
                        )),
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Scrollbar(
                          thickness: 3,
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (BuildContext context,
                                      int index) =>
                                  Divider(
                                    endIndent: 10,
                                    indent: 10,
                                    height: 1,
                                    thickness: 1,
                                    color: Color.fromRGBO(101, 101, 101, 0.2),
                                  ),
                              itemCount: listOfInfo.reportList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(
                                      listOfInfo.reportList[index].toString(),
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(101, 101, 101, 1),
                                          fontSize: 15)),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  onTap: () {
                                    setState(() {
                                      reportListDropdown = true;
                                      reportHint = listOfInfo.reportList[index]
                                          .toString();
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
      ),
    ));
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
              "Submit",
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () async {
              if (reportHint == "- Select from below") {
                setState(() {
                  error = "Reason must be selected";
                });
              } else {
                setState(() {
                  error = "";
                });
                buttonBloc.add(reportContract(widget.contractID, reportHint,
                    reportDetails.text.toString()));
              }
            },
          )),
    );
  }
}
