import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Widgets/LoaderSmallerCircular.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/mywork_bloc.dart';

class ClientReviews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClientReviewsState();
}

class ClientReviewsState extends State<ClientReviews> {
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
        : response.length == 0
            ? Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Client has no reviews!",
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
                  return Card(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                    "${baseUrl.getpicUrl}${response[index]['worker_profile_picture']}",
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
                                response[index]['worker_name'],
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
                                      visible: int.parse(response[index]
                                                  ['rating']
                                              .toString()) >
                                          1,
                                      child: Icon(Icons.star_border_outlined,
                                          color:
                                              Color.fromRGBO(249, 175, 25, 1))),
                                  Visibility(
                                      visible: int.parse(response[index]
                                                  ['rating']
                                              .toString()) >
                                          2,
                                      child: Icon(Icons.star_border_outlined,
                                          color:
                                              Color.fromRGBO(249, 175, 25, 1))),
                                  Visibility(
                                      visible: int.parse(response[index]
                                                  ['rating']
                                              .toString()) >
                                          3,
                                      child: Icon(Icons.star_border_outlined,
                                          color:
                                              Color.fromRGBO(249, 175, 25, 1))),
                                  Visibility(
                                      visible: int.parse(response[index]
                                                  ['rating']
                                              .toString()) >
                                          4,
                                      child: Icon(Icons.star_border_outlined,
                                          color:
                                              Color.fromRGBO(249, 175, 25, 1))),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("\"" + response[index]['text'] + "\"",
                                  style: TextStyle(
                                      color: Color.fromRGBO(101, 101, 101, 1),
                                      fontSize: 12))
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              );
  }
}
