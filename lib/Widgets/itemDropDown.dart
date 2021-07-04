import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:revised_quickassist/Model/registrationInformation.dart';

class itemDropDown extends StatefulWidget {
  List<String> content;
  String hint;
  String page;
  itemDropDown(this.content, this.hint, this.page);

  @override
  itemDropDownState createState() => itemDropDownState(content, hint, page);
}

class itemDropDownState extends State<itemDropDown> {
  bool selected = true;
  String hint = "";
  List<String> content = [];
  String page;
  itemDropDownState(this.content, this.hint, this.page);

  @override
  void initState() {
    if (page == "select_city") {
      registrationInformation.setCity(hint);
    }
    if (page == "vehicle_selection") {
      registrationInformation.setVehicle(hint);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollcont = new ScrollController();
    return Center(
        child: GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(117, 117, 117, 0.7)),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromRGBO(247, 247, 247, 1),
          ),
          height: selected ? 52.0 : 250.0,
          duration: Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn,
          child: selected
              ?
              //Menu not clicked hence Collapsed
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Text(
                            hint,
                            style: TextStyle(
                                color: Color.fromRGBO(32, 32, 32, 1),
                                fontSize: 15),
                          )),
                      Flexible(
                        flex: 0,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            selected
                                ? Icons.keyboard_arrow_down_outlined
                                : Icons.keyboard_arrow_up_outlined,
                            color: Color.fromRGBO(13, 106, 106, 1),
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
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: Text(
                                  hint,
                                  style: TextStyle(
                                      color: Color.fromRGBO(32, 32, 32, 1),
                                      fontSize: 15),
                                )),
                            Flexible(
                              flex: 0,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                    selected
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.keyboard_arrow_up_outlined,
                                    color: Color.fromRGBO(13, 106, 106, 1)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          height: 1.0,
                          color: Color.fromRGBO(13, 106, 106, 1),
                        )),
                    Expanded(
                      flex: 7,
                      child: Container(
                          child: Scrollbar(
                              thickness: 3,
                              isAlwaysShown: true,
                              controller: scrollcont,
                              child: ListView.separated(
                                  controller: scrollcont,
                                  scrollDirection: Axis.vertical,
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
                                      Divider(
                                        endIndent: 10,
                                        indent: 10,
                                        height: 1,
                                        thickness: 1,
                                        color:
                                            Color.fromRGBO(101, 101, 101, 0.2),
                                      ),
                                  itemCount: content.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(content[index],
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  101, 101, 101, 1),
                                              fontSize: 15)),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      onTap: () {
                                        if (page == "select_city") {
                                          registrationInformation
                                              .setCity(content[index]);
                                        } else if (page ==
                                            "vehicle_selection") {
                                          registrationInformation
                                              .setVehicle(content[index]);
                                        }
                                        setState(() {
                                          selected = true;
                                          hint = content[index];
                                        });
                                      },
                                    );
                                  }))),
                    ),
                  ],
                ),
        ),
      ),
    ) // snapshot.data  :- get your object which is pass from your downloadData() function

        );
  }
}
