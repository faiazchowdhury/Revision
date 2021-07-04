import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revised_quickassist/Model/registrationInformation.dart';

class datePickerRegistration extends StatefulWidget {
  @override
  datePickerRegistrationState createState() => datePickerRegistrationState();
}

class datePickerRegistrationState extends State<datePickerRegistration> {
  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(55, 0, 55, 0),
          height: 52,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
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
                selectedDate == null
                    ? "Select Birth date (dd/mm/yyyy)"
                    : selectedDate.day.toString() +
                        "/" +
                        selectedDate.month.toString() +
                        "/" +
                        selectedDate.year.toString(),
                style: TextStyle(
                    color: selectedDate == null
                        ? Color.fromRGBO(32, 32, 32, 0.5)
                        : Color.fromRGBO(13, 106, 106, 1),
                    fontSize: 16),
              )
            ],
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.from(
              colorScheme: ColorScheme(
                  background: Colors.white,
                  primary: Color.fromRGBO(13, 106, 106, 1),
                  primaryVariant: Color.fromRGBO(13, 106, 106, 1),
                  secondary: Color.fromRGBO(13, 106, 106, 1),
                  secondaryVariant: Color.fromRGBO(13, 106, 106, 1),
                  surface: Color.fromRGBO(13, 106, 106, 1),
                  error: Colors.red,
                  onPrimary: Colors.white,
                  onBackground: Colors.white,
                  onError: Colors.red,
                  onSecondary: Color.fromRGBO(13, 106, 106, 1),
                  onSurface: Color.fromRGBO(13, 106, 106, 1),
                  brightness:
                      Brightness.light)), // This will change to light theme.
          child: child,
        );
      },

      selectableDayPredicate: _decideWhichDayToEnable,
      context: context,

      initialDate: DateFormat('dd-MM-yyyy').parse(
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year - 18}"),
      // Refer step 1
      firstDate: DateTime(DateTime.now().year - 101),
      lastDate: DateFormat('dd-MM-yyyy').parse(
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year - 18}"),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      registrationInformation.setDOB(DateFormat("yyyy-MM-dd").format(picked));
    }
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now())) ||
        day.isBefore(DateTime.now().subtract(Duration(days: 36500)))) {
      return false;
    }
    return true;
  }
}
