import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Model/serviceProviderReviewsList.dart';
import 'package:revised_quickassist/UI/AllPages/ServicesTab/Services.dart'
    as services;
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/bloc/Bloc/services_bloc.dart';

class Reviews extends StatefulWidget {
  final services.ServicesState servicesState;
  Reviews(this.servicesState);

  @override
  ReviewsState createState() => ReviewsState();
}

class ReviewsState extends State<Reviews> {
  double width, height;
  final bloc = new ServicesBloc();

  @override
  void initState() {
    if (serviceProviderReviewsList.getResponse == null) {
      bloc.add(getServiceProviderReviews());
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
        if (state is ServicesInitial) {
          return displayList();
        } else if (state is ServicesLoading) {
          return LoaderSmallerCircular();
        } else if (state is ServicesLoaded) {
          return displayList();
        }
      },
    );
  }

  Widget displayList() {
    var res = serviceProviderReviewsList.getResponse;
    return Container(
        child: serviceProviderReviewsList.getCode != 200
            ? SomethingWentWrong()
            : res.length == 0
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "You have no reviews!",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(13, 106, 106, 0.29)),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: res.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: index == res.length - 1
                            ? EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10)
                            : EdgeInsets.only(top: 10, left: 10, right: 10),
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 0,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2000),
                                      child: Image.network(
                                        "${baseUrl.getUrl}${res[index]['client_profile_picture']}",
                                        width: 65,
                                        height: 65,
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    res[index]['client_name'],
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
                                          color:
                                              Color.fromRGBO(249, 175, 25, 1)),
                                      Visibility(
                                          visible: int.parse(res[index]
                                                      ['rating']
                                                  .toString()) >
                                              1,
                                          child: Icon(
                                              Icons.star_border_outlined,
                                              color: Color.fromRGBO(
                                                  249, 175, 25, 1))),
                                      Visibility(
                                          visible: int.parse(res[index]
                                                      ['rating']
                                                  .toString()) >
                                              2,
                                          child: Icon(
                                              Icons.star_border_outlined,
                                              color: Color.fromRGBO(
                                                  249, 175, 25, 1))),
                                      Visibility(
                                          visible: int.parse(res[index]
                                                      ['rating']
                                                  .toString()) >
                                              3,
                                          child: Icon(
                                              Icons.star_border_outlined,
                                              color: Color.fromRGBO(
                                                  249, 175, 25, 1))),
                                      Visibility(
                                          visible: int.parse(res[index]
                                                      ['rating']
                                                  .toString()) >
                                              4,
                                          child: Icon(
                                              Icons.star_border_outlined,
                                              color: Color.fromRGBO(
                                                  249, 175, 25, 1))),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("\"" + res[index]['text'] + "\"",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(101, 101, 101, 1),
                                          fontSize: 12))
                                ],
                              ))
                            ],
                          ),
                        ),
                      );
                    },
                  ));
  }
}
