import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class TransactionHistory extends StatefulWidget {
  @override
  TransactionHistoryState createState() => TransactionHistoryState();
}

class TransactionHistoryState extends State<TransactionHistory> {
  double width, height;
  final bloc = new ProfileBloc();
  List<bool> transactionHistoryDropdown;

  @override
  void initState() {
    bloc.add(getTransactionHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AllPagesAppBar.appBar(context, true, false, "Transaction History"),
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener(
          bloc: bloc,
          listener: (context, state) {
            if (state is ProfileLoadedwithResponse) {
              if (state.code == 200) {
                transactionHistoryDropdown =
                    List.filled(state.response.length, false);
              }
            }
          },
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is ProfileInitial) {
                return Center(child: loadingCircle());
              } else if (state is ProfileLoading) {
                return Center(child: loadingCircle());
              } else if (state is ProfileLoadedwithResponse) {
                return displayScreen(state.response, state.code);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget displayScreen(response, int code) {
    return code != 200
        ? SomethingWentWrong()
        : response.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "No transactions made!",
                  style: TextStyle(
                      color: Color.fromRGBO(13, 106, 106, 0.29),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Container(
                child: ListView.separated(
                    padding: EdgeInsets.all(10),
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 1,
                        color: Color.fromRGBO(112, 112, 112, 0.11),
                      );
                    },
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            transactionHistoryDropdown[index] =
                                !transactionHistoryDropdown[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(seconds: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: Color.fromRGBO(13, 106, 106, 1),
                                        size: 30,
                                      ),
                                      transactionHistoryDropdown[index] == false
                                          ? Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.keyboard_arrow_up_outlined,
                                              color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: "Payment Method: ",
                                            children: [
                                              TextSpan(
                                                text: "Bank",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        39, 39, 39, 1),
                                                    fontSize: 15),
                                              )
                                            ],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                fontSize: 15),
                                          )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: "Bank Name: ",
                                            children: [
                                              TextSpan(
                                                text: response[index]
                                                    ['bank_name'],
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        39, 39, 39, 1),
                                                    fontSize: 15),
                                              )
                                            ],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                fontSize: 15),
                                          )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: "Status: ",
                                            children: [
                                              TextSpan(
                                                text: response[index]['status'],
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        39, 39, 39, 1),
                                                    fontSize: 15),
                                              )
                                            ],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                fontSize: 15),
                                          )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: "Date: ",
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${DateFormat('dd-MM-yyyy').format(DateTime.parse(response[index]['created_on']))}",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        39, 39, 39, 1),
                                                    fontSize: 15),
                                              )
                                            ],
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    13, 106, 106, 1),
                                                fontSize: 15),
                                          )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Visibility(
                                        visible:
                                            transactionHistoryDropdown[index],
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "Amount: ",
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${response[index]['amount']}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 39, 39, 1),
                                                      fontSize: 15),
                                                )
                                              ],
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  fontSize: 15),
                                            )
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Visibility(
                                        visible:
                                            transactionHistoryDropdown[index],
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "Account Number: ",
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${response[index]['bank_account_number']}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 39, 39, 1),
                                                      fontSize: 15),
                                                )
                                              ],
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  fontSize: 15),
                                            )
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Visibility(
                                        visible:
                                            transactionHistoryDropdown[index],
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "Phone number: ",
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${response[index]['phone_number']}",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          39, 39, 39, 1),
                                                      fontSize: 15),
                                                )
                                              ],
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      13, 106, 106, 1),
                                                  fontSize: 15),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }));
  }
}
