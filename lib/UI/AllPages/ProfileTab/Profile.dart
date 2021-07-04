import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/baseUrl.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';
import 'package:revised_quickassist/UI/AllPages/ProfileTab/AboutApp.dart';
import 'package:revised_quickassist/UI/AllPages/ProfileTab/ChangePassword.dart';
import 'package:revised_quickassist/UI/AllPages/ProfileTab/PhoneNumber.dart';
import 'package:revised_quickassist/Widgets/AllPagesAppBar.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

import '../../../main.dart';
import 'Payment.dart';
import 'PersonalInfo.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  double width, height;
  final bloc = ProfileBloc();

  @override
  void initState() {
    if (serviceProviderInfo.name == null) {
      bloc.add(getInfo());
    }
    if (serviceProviderInfo.img == null) {
      bloc.add(getServiceProviderPicture());
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
      backgroundColor: Colors.white,
      appBar: AllPagesAppBar.appBar(context, false, false, "Profile"),
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  BlocBuilder(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is ProfileInitial) {
                        return loadedInfo();
                      } else if (state is ProfileLoading) {
                        return loadingCircle();
                      } else if (state is ProfileLoadedwithResponse) {
                        return loadedInfo();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(39, 39, 39, 1)),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: ChangePassword(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Edit",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromRGBO(129, 187, 46, 1))),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Color.fromRGBO(129, 187, 46, 1),
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Phone Number",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(39, 39, 39, 1)),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: PhoneNumber(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Edit",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color.fromRGBO(129, 187, 46, 1),
                                    size: 10,
                                  ),
                                ],
                              ),
                            )),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Personal Information",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(39, 39, 39, 1)),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: PersonalInfo(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Edit",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color.fromRGBO(129, 187, 46, 1),
                                    size: 10,
                                  ),
                                ],
                              ),
                            )),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Payment",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(39, 39, 39, 1)),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: Payment(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Edit",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromRGBO(129, 187, 46, 1))),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color.fromRGBO(129, 187, 46, 1),
                                    size: 10,
                                  ),
                                ],
                              ),
                            )),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "About",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(39, 39, 39, 1)),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: AboutApp(),
                            withNavBar:
                                false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Color.fromRGBO(129, 187, 46, 1),
                                size: 10,
                              ),
                            )),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 1,
                    color: Color.fromRGBO(112, 112, 112, 0.11),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      authToken.setToken(null);
                      final _storage = FlutterSecureStorage();
                      await _storage.deleteAll();
                      pushNewScreen(
                        context,
                        screen: MyApp(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      shadowColor: Color.fromRGBO(129, 187, 46, 1),
                      elevation: 2,
                      child: Container(
                        alignment: Alignment.center,
                        width: width / 1.4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(129, 187, 46, 1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Log out",
                          style: TextStyle(
                              color: Color.fromRGBO(129, 187, 46, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadedInfo() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1000),
              border: Border.all(color: Colors.black.withOpacity(0.2))),
          alignment: Alignment.center,
          height: 150,
          width: 150,
          padding: EdgeInsets.all(5),
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.loose,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                    "${baseUrl.getUrl}${serviceProviderInfo.img}",
                    height: 150,
                    width: 150,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    /*setState(() {
                                      pages = "upload_picture";
                                    });*/
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(2000),
                            bottomRight: Radius.circular(2000)),
                        child: Container(
                          width: 150,
                          height: 75,
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            "Upload\nImage",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          serviceProviderInfo.name,
          style: TextStyle(
              color: Color.fromRGBO(13, 106, 106, 1),
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
