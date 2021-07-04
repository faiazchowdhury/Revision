import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/UI/AllPages/ProfileTab/TransactionHistory.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';
import 'package:revised_quickassist/UI/AllPages/ProfileTab/AddPaymentMethod.dart';

class Payment extends StatefulWidget {
  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  double width, height;
  final balanceBloc = new ProfileBloc();
  final bankInfoBloc = new ProfileBloc();
  final withdrawBloc = new ProfileBloc();
  final GlobalKey<ScaffoldState> scaffPaymentKey = new GlobalKey();

  @override
  void initState() {
    balanceBloc.add(getBalance());
    bankInfoBloc.add(getBankInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => balanceBloc),
        BlocProvider(create: (context) => bankInfoBloc),
        BlocProvider(create: (context) => withdrawBloc)
      ],
      child: Scaffold(
        key: scaffPaymentKey,
        appBar: AllPagesAppBar.appBar(context, true, false, "Payment"),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder(
          bloc: bankInfoBloc,
          builder: (context, state) {
            if (state is ProfileInitial) {
              return Container();
            } else if (state is ProfileLoading) {
              return Container();
            } else if (state is ProfileLoadedwithResponse) {
              return state.code == 200
                  ? state.response.length == 0
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          height: 42,
                          width: width - 120,
                          child: Material(
                              elevation: 2,
                              shadowColor: Color.fromRGBO(129, 187, 46, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Color.fromRGBO(139, 187, 46, 1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: FlatButton(
                                  height: 40,
                                  minWidth: width - 120,
                                  color: Color.fromRGBO(139, 187, 46, 0.39),
                                  textColor: Colors.white,
                                  child: Text(
                                    "+ Add new payment method",
                                  ),
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddPaymentMethod(),
                                        ));
                                    bankInfoBloc.add(getBankInfo());
                                  },
                                ),
                              )),
                        )
                      : Container()
                  : Container();
            }
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 3,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Current Balance",
                        style: TextStyle(
                            color: Color.fromRGBO(32, 32, 32, 1), fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder(
                        bloc: balanceBloc,
                        builder: (context, state) {
                          if (state is ProfileInitial) {
                            return loadingCircle();
                          } else if (state is ProfileLoading) {
                            return loadingCircle();
                          } else if (state is ProfileLoadedwithResponse) {
                            return balanceDisplay(state.response, state.code);
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
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
                          flex: 1,
                          child: Text(
                            "Transaction History",
                            style: TextStyle(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                fontSize: 15),
                          )),
                      Expanded(
                          flex: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransactionHistory(),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(129, 187, 46, 1),
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
              SizedBox(
                height: 5,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(
                            color: Color.fromRGBO(13, 106, 106, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 1,
                        color: Color.fromRGBO(112, 112, 112, 0.11),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder(
                        bloc: bankInfoBloc,
                        builder: (context, state) {
                          if (state is ProfileInitial) {
                            return Center(child: loadingCircle());
                          } else if (state is ProfileLoading) {
                            return Center(child: loadingCircle());
                          } else if (state is ProfileLoadedwithResponse) {
                            return bankInfoDisplay(state.response, state.code);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget balanceDisplay(response, int code) {
    return code != 200
        ? SomethingWentWrong()
        : Column(
            children: [
              Text(
                "\$ ${response['balance']}",
                style: TextStyle(
                    color: Color.fromRGBO(13, 106, 106, 1),
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 1,
                color: Color.fromRGBO(112, 112, 112, 0.11),
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder(
                bloc: bankInfoBloc,
                builder: (context, state) {
                  if (state is ProfileInitial) {
                    return Container();
                  } else if (state is ProfileLoading) {
                    return loadingCircle();
                  } else if (state is ProfileLoadedwithResponse) {
                    return state.code != 200
                        ? SomethingWentWrong()
                        : BlocListener(
                            bloc: withdrawBloc,
                            listener: (context, state) {
                              if (state is ProfileLoadedwithResponse) {
                                if (state.code == 200) {
                                  balanceBloc.add(getBalance());
                                  snackbar(scaffPaymentKey,
                                          "Request placed successfully")
                                      .showSnackbar();
                                } else {
                                  if (state.code == 400) {
                                    snackbar(scaffPaymentKey,
                                            "Request has already been posted!")
                                        .showSnackbar();
                                  } else {
                                    snackbar(scaffPaymentKey,
                                            "Request couldn't be placed. Try again!")
                                        .showSnackbar();
                                  }
                                }
                              }
                            },
                            child: BlocBuilder(
                              bloc: withdrawBloc,
                              builder: (context, stat) {
                                if (stat is ProfileInitial) {
                                  return withdrawButton(
                                      response, state.response);
                                } else if (state is ProfileLoading) {
                                  return loadingCircle();
                                } else if (state is ProfileLoadedwithResponse) {
                                  return withdrawButton(
                                      response, state.response);
                                }
                              },
                            ),
                          );
                  }
                },
              )
            ],
          );
  }

  Widget bankInfoDisplay(response, int code) {
    return code != 200
        ? SomethingWentWrong()
        : response.length == 0
            ? Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  "No payment method added",
                  style: TextStyle(color: Color.fromRGBO(32, 32, 32, 0.5)),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: SvgPicture.asset(
                        "assets/bank.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(response[0]['bank_account_number']),
                    ),
                    Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onTap: () async {
                          bankInfoBloc.add(deleteBankInfo());
                        },
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Color.fromRGBO(129, 187, 46, 1),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                    color: Color.fromRGBO(129, 187, 46, 1),
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
  }

  Widget withdrawButton(balanceResponse, bankInfoResponse) {
    return GestureDetector(
      onTap: () async {
        if (bankInfoResponse.length == 0) {
          snackbar(scaffPaymentKey, "No payment method found!").showSnackbar();
        } else {
          if (balanceResponse['balance'] <= 25) {
            snackbar(scaffPaymentKey,
                    "Balance needs to be more than \$25 to withdraw")
                .showSnackbar();
          } else {
            withdrawBloc.add(withdrawBalance());
          }
        }
      },
      child: Container(
        color: Colors.white,
        child: Text(
          "Withdraw Payment",
          style: TextStyle(
              color: balanceResponse['balance'] <= 25 ||
                      bankInfoResponse.length == 0
                  ? Color.fromRGBO(101, 101, 101, 1)
                  : Color.fromRGBO(129, 187, 46, 1),
              fontSize: 15),
        ),
      ),
    );
  }
}
