import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/Model/availabilityListResponse.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/availability_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddSchedule extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffKey;
  AddSchedule(this.scaffKey);

  @override
  AddScheduleState createState() => AddScheduleState();
}

class AddScheduleState extends State<AddSchedule> {
  double width, height;
  bool startDateSelected = true,
      availability_slot1 = false,
      availability_slot2 = false,
      availability_slot3 = false;
  String selectedStartDate, selectedEndDate, error = "";
  GlobalKey<ScaffoldState> scaffKey = new GlobalKey();
  final bloc = new AvailabilityBloc();
  List<String> startendDate = [];

  @override
  void initState() {
    startendDate = availabilityListResponse.getStartEndDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      key: scaffKey,
      backgroundColor: Colors.white,
      appBar: AllPagesAppBar.appBar(context, true, false, "Add Schedule"),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                width: width - 60,
                child: Text(
                  "Start Date",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 2,
                    child: Container(
                      width: width - 60,
                      height: 52,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 247, 1),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color.fromRGBO(117, 117, 117, 0.7),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              color: Color.fromRGBO(13, 106, 106, 1)),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            selectedStartDate == null
                                ? "Select start date (dd/mm/yyyy)"
                                : selectedStartDate,
                            style: TextStyle(
                                color: selectedStartDate == null
                                    ? Color.fromRGBO(32, 32, 32, 0.5)
                                    : Color.fromRGBO(13, 106, 106, 1),
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )),
              Container(
                width: startDateSelected ? 0 : width,
                height: startDateSelected ? 0 : 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_rounded, color: Colors.red, size: 15),
                    Text(
                      "Start date needs to be selected first!",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                width: width - 60,
                child: Text(
                  "End Date",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (selectedStartDate == null) {
                      setState(() {
                        startDateSelected = false;
                      });
                    } else {
                      _selectEndDate(context);
                    }
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 2,
                    child: Container(
                        width: width - 60,
                        height: 52,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                color: Color.fromRGBO(13, 106, 106, 1)),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              selectedEndDate == null
                                  ? "Select end date (dd/mm/yyyy)"
                                  : selectedEndDate,
                              style: TextStyle(
                                  color: selectedEndDate == null
                                      ? Color.fromRGBO(32, 32, 32, 0.5)
                                      : Color.fromRGBO(13, 106, 106, 1),
                                  fontSize: 16),
                            )
                          ],
                        )),
                  )),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                width: width - 60,
                child: Text(
                  "Time Slots",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromRGBO(101, 101, 101, 1)),
                ),
              ),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width - 60,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              availability_slot1 = !availability_slot1;
                            });
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: availability_slot1
                                      ? Color.fromRGBO(13, 106, 106, 1)
                                      : Color.fromRGBO(247, 247, 247, 1),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color.fromRGBO(117, 117, 117, 0.7),
                                  ),
                                ),
                                width: ((width - 60) / 2) - 5,
                                height: 52,
                                child: Center(
                                  child: Text(
                                    "8:00 AM - 12:00 PM",
                                    style: TextStyle(
                                      color: availability_slot1
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              availability_slot2 = !availability_slot2;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: availability_slot2
                                    ? Color.fromRGBO(13, 106, 106, 1)
                                    : Color.fromRGBO(247, 247, 247, 1),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color.fromRGBO(117, 117, 117, 0.7),
                                ),
                              ),
                              width: ((width - 60) / 2) - 5,
                              height: 52,
                              child: Center(
                                  child: Text("12:00 PM - 5:00 PM",
                                      style: TextStyle(
                                        color: availability_slot2
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15,
                                      )))),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        availability_slot3 = !availability_slot3;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: availability_slot3
                              ? Color.fromRGBO(13, 106, 106, 1)
                              : Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          ),
                        ),
                        width: ((width - 60) / 2) - 5,
                        height: 52,
                        child: Center(
                          child: Text("5:00 PM - 11:00 PM",
                              style: TextStyle(
                                color: availability_slot3
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15,
                              )),
                        )),
                  )
                ],
              )),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: width - 60,
                child: Text(
                  "*You can select multiple timeslot. Selected dates will show availability from this time slot. Also pick the start date & end date from calendar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(249, 175, 25, 1), fontSize: 15),
                ),
              ),
              ErrorMessage(error),
              BlocProvider(
                create: (context) => bloc,
                child: BlocListener(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is AvailabilityLoadedWithResponse) {
                      if (state.code == 200) {
                        snackbar(
                                widget.scaffKey, "Successfully added schedule!")
                            .showSnackbar();
                        Navigator.pop(context);
                      } else {
                        snackbar(scaffKey,
                                "Something went wrong! Please try again")
                            .showSnackbar();
                      }
                    }
                  },
                  child: BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is AvailabilityInitial) {
                        return continueButton();
                      } else if (state is AvailabilityLoading) {
                        return loadingCircle();
                      } else if (state is AvailabilityLoadedWithResponse) {
                        return continueButton();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
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
              "Add",
              style: TextStyle(fontSize: 14),
            ),
            onPressed: () {
              if (selectedStartDate == null ||
                  selectedEndDate == null ||
                  (availability_slot1 == false &&
                      availability_slot2 == false &&
                      availability_slot3 == false)) {
                setState(() {
                  error = "Choose start date, end date and a time slot!";
                });
              } else {
                setState(() {
                  error = "";
                  bloc.add(addAvailability(
                      availability_slot1,
                      availability_slot2,
                      availability_slot3,
                      DateFormat('yyyy-MM-dd').format(
                          DateFormat('dd/MM/yyyy').parse(selectedStartDate)),
                      DateFormat('yyyy-MM-dd').format(
                          DateFormat('dd/MM/yyyy').parse(selectedEndDate))));
                });
              }
            },
          )),
    );
  }

  _selectDate(BuildContext context) async {
    List<DateTime> forbidenDates = [];
    if (startendDate.length != null) {
      for (int i = 0; i < startendDate.length; i++) {
        List<String> split = startendDate[i].split(" - ");
        for (DateTime j = DateTime.parse(split[0]);
            DateTime.parse(split[1]).isAfter(j) ||
                DateTime.parse(split[1]).isAtSameMomentAs(j);
            j = DateTime.parse(j.toString()).add(Duration(days: 1))) {
          if (forbidenDates.isEmpty) {
            forbidenDates = [j];
          } else {
            if (forbidenDates.contains(j)) {
            } else {
              forbidenDates.add(j);
            }
          }
        }
      }
    }
    return showDialog(
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(50, 120, 50, 120),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SfDateRangePicker(
                            view: DateRangePickerView.month,
                            minDate: DateTime.now(),
                            maxDate: DateTime.now().add(Duration(days: 6)),
                            enablePastDates: false,
                            headerHeight: 80,
                            monthViewSettings: DateRangePickerMonthViewSettings(
                              blackoutDates: forbidenDates,
                            ),
                            headerStyle: DateRangePickerHeaderStyle(
                                backgroundColor:
                                    Color.fromRGBO(13, 106, 106, 1),
                                textStyle: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onSelectionChanged: (date) {
                              setState(() {
                                selectedStartDate =
                                    DateFormat('dd/MM/yyyy').format(date.value);
                                selectedEndDate = null;
                                startDateSelected = true;
                              });
                            },
                            showNavigationArrow: true,
                            selectionColor: Color.fromRGBO(13, 106, 106, 1),
                            selectionMode: DateRangePickerSelectionMode.single,
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.only(right: 30),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Color.fromRGBO(13, 106, 106, 1),
                              fontSize: 15,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        },
        context: context);
  }

  _selectEndDate(BuildContext context) {
    DateTime maxDate = DateTime.now().add(Duration(days: 7));
    if (startendDate.length != 0) {
      for (int i = 0; i < startendDate.length; i++) {
        List<String> split = startendDate[i].split(" - ");
        if (DateFormat('dd/MM/yyyy')
            .parse(selectedStartDate)
            .isBefore(DateTime.parse(split[0]))) {
          if (maxDate.isAfter(DateTime.parse(split[0]))) {
            maxDate = DateTime.parse(split[0]);
          } else {}
        }
      }
    }
    return showDialog(
      builder: (context) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.fromLTRB(50, 120, 50, 120),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SfDateRangePicker(
                          view: DateRangePickerView.month,
                          minDate:
                              DateFormat('dd/MM/yyyy').parse(selectedStartDate),
                          maxDate: maxDate.subtract(Duration(days: 1)),
                          enablePastDates: false,
                          headerHeight: 80,
                          monthViewSettings: DateRangePickerMonthViewSettings(),
                          headerStyle: DateRangePickerHeaderStyle(
                              backgroundColor: Color.fromRGBO(13, 106, 106, 1),
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          onSelectionChanged: (date) {
                            setState(() {
                              selectedEndDate =
                                  DateFormat('dd/MM/yyyy').format(date.value);
                            });
                          },
                          showNavigationArrow: true,
                          selectionColor: Color.fromRGBO(13, 106, 106, 1),
                          selectionMode: DateRangePickerSelectionMode.single,
                        ),
                      )),
                ),
                Expanded(
                  flex: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.only(right: 30),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: Color.fromRGBO(13, 106, 106, 1),
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                )
              ],
            ));
      },
      context: context,
    );
  }
}
