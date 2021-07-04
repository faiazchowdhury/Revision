import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class ReviewClient extends StatefulWidget {
  final String contractID, clientID;
  ReviewClient(this.contractID, this.clientID);

  @override
  State<StatefulWidget> createState() => ReviewClientState();
}

class ReviewClientState extends State<ReviewClient> {
  double width, height;
  bool review_5star = false, review_3star = false, review_1star = false;
  String error = "";
  TextEditingController reviewClientDetails = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  final bloc = new MyworkBloc();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffoldKey,
      appBar: AllPagesAppBar.appBar(context, true, false, "Review Client"),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 2,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 40),
                child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/rating.svg"),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "How well the client was?",
                          style: TextStyle(
                              color: Color.fromRGBO(32, 32, 32, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  review_5star = !review_5star;
                                  review_1star = false;
                                  review_3star = false;
                                });
                              },
                              child: Container(
                                width: width / 3,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: review_5star
                                      ? Color.fromRGBO(129, 187, 46, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: review_5star
                                        ? Colors.white
                                        : Color.fromRGBO(129, 187, 46, 1),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_5star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_5star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_5star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_5star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_5star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        )
                                      ],
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Great",
                                      style: TextStyle(
                                        color: review_5star
                                            ? Colors.white
                                            : Color.fromRGBO(129, 187, 46, 1),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  review_3star = !review_3star;
                                  review_1star = false;
                                  review_5star = false;
                                });
                              },
                              child: Container(
                                width: width / 3,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: review_3star
                                      ? Color.fromRGBO(129, 187, 46, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: review_3star
                                        ? Colors.white
                                        : Color.fromRGBO(129, 187, 46, 1),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_3star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_3star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: review_3star
                                              ? Colors.white
                                              : Color.fromRGBO(129, 187, 46, 1),
                                        ),
                                      ],
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Very Good",
                                      style: TextStyle(
                                        color: review_3star
                                            ? Colors.white
                                            : Color.fromRGBO(129, 187, 46, 1),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              review_1star = !review_1star;
                              review_3star = false;
                              review_5star = false;
                            });
                          },
                          child: Container(
                            width: width / 3,
                            height: 70,
                            decoration: BoxDecoration(
                              color: review_1star
                                  ? Color.fromRGBO(129, 187, 46, 1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: review_1star
                                    ? Colors.white
                                    : Color.fromRGBO(129, 187, 46, 1),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      color: review_1star
                                          ? Colors.white
                                          : Color.fromRGBO(129, 187, 46, 1),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Poor",
                                  style: TextStyle(
                                    color: review_1star
                                        ? Colors.white
                                        : Color.fromRGBO(129, 187, 46, 1),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ErrorMessage(error),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          width: width - 60,
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
                            width: width - 60,
                            height: 215,
                            child: TextFormField(
                              controller: reviewClientDetails,
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
                          height: 25,
                        ),
                        BlocProvider(
                          create: (context) => bloc,
                          child: BlocListener(
                            bloc: bloc,
                            listener: (context, state) {
                              if (state is MyworkLoadedwithResponse) {
                                if (state.code == 200) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  snackbar(scaffoldKey,
                                      "Something went wrong! Please try again!");
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
                    )),
              ),
            ],
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
              "Submit",
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              if (review_3star == false &&
                  review_1star == false &&
                  review_5star == false) {
                setState(() {
                  error = "One of the review stars must be selected";
                });
              } else {
                bloc.add(postClientReview(
                    widget.contractID,
                    widget.clientID,
                    review_1star
                        ? 1
                        : review_3star
                            ? 3
                            : 5,
                    reviewClientDetails.text.toString()));
              }
            },
          )),
    );
  }
}
