import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/ErrorMessage.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/Widgets/snackbar.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class AddPaymentMethod extends StatefulWidget {
  @override
  AddPaymentMethodState createState() => AddPaymentMethodState();
}

class AddPaymentMethodState extends State<AddPaymentMethod> {
  double width, height;
  String error = "";
  final noc = TextEditingController();
  final cn = TextEditingController();
  final exp = TextEditingController();
  final ccv = TextEditingController();
  final emailAccountCodeController = TextEditingController();
  final accountHolderAddressController = TextEditingController();
  final accountHolderBankNameController = TextEditingController();
  final bankAccountNumberController = TextEditingController();
  final abaCodeController = TextEditingController();
  final accountHolderController = new TextEditingController();
  final accountPhoneNumberController = new TextEditingController();
  final bloc = new ProfileBloc();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AllPagesAppBar.appBar(context, true, false, "Add Payment Method"),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 3,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(20),
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
                  height: 20,
                ),
                Text("Account Holder Full Name",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: accountHolderController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "Full Name",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Acount Holder Address",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: accountHolderAddressController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "Address",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Bank Name",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: accountHolderBankNameController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "Bank Name",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Bank Account Number",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bankAccountNumberController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "Account Number",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("ABA/ACH Routing Code",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: abaCodeController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "9 digit code",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Phone Number",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  controller: accountPhoneNumberController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: SizedBox(
                        width: 60,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(children: [
                            Text("   +1  ",
                                style: TextStyle(
                                    color: Color.fromRGBO(45, 45, 45, 1),
                                    fontSize: 15)),
                            Container(
                              height: 35.0,
                              width: 0.5,
                              color: Colors.black38,
                              margin:
                                  const EdgeInsets.only(left: 5.0, right: 5),
                            ),
                          ]),
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "Number",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Email (optional)",
                    style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1), fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailAccountCodeController,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      filled: true,
                      fillColor: Color.fromRGBO(247, 247, 247, 1),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.7),
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(117, 117, 117, 0.1),
                          )),
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(32, 32, 32, 0.5))),
                ),
                SizedBox(
                  height: 25,
                ),
                ErrorMessage(error),
                SizedBox(
                  height: 25,
                ),
                BlocProvider(
                  create: (context) => bloc,
                  child: BlocListener(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is ProfileLoadedwithResponse) {
                        if (state.code == 200) {
                          Navigator.pop(context);
                        } else {
                          snackbar(scaffoldKey,
                                  "Something went wrong!Please try again!")
                              .showSnackbar();
                        }
                      }
                    },
                    child: BlocBuilder(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is ProfileInitial) {
                          return addButton();
                        } else if (state is ProfileLoading) {
                          return Center(child: loadingCircle());
                        } else if (state is ProfileLoadedwithResponse) {
                          return addButton();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(129, 187, 46, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return GestureDetector(
      onTap: () async {
        if (accountPhoneNumberController.text == "" ||
            accountHolderController.text == "" ||
            bankAccountNumberController.text == "" ||
            accountHolderBankNameController.text == "" ||
            abaCodeController.text == "" ||
            accountHolderAddressController.text == "") {
          setState(() {
            error =
                "All the boxes except for optional box, needs to be filled!";
          });
        } else {
          bloc.add(addPayment(
              abaCodeController.text,
              accountHolderController.text,
              accountPhoneNumberController.text,
              accountHolderAddressController.text,
              accountHolderBankNameController.text,
              bankAccountNumberController.text,
              emailAccountCodeController.text));
          setState(() {
            error = "";
          });
        }
      },
      child: Material(
        shadowColor: Color.fromRGBO(129, 187, 46, 1),
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 47,
          decoration: BoxDecoration(
            color: Color.fromRGBO(129, 187, 46, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "+ Add Payment Method",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
