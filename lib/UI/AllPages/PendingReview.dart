import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:revised_quickassist/Model/authToken.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';

import '../../main.dart';
import 'ProfileTab/Profile.dart';

class PendingReview extends StatelessWidget {
  double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Material(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                shadowColor: Color.fromRGBO(13, 106, 106, 1),
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(13, 106, 106, 1),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  width: width,
                  child: SafeArea(
                    child: Text(
                      "Hi ${serviceProviderInfo.name}, \nYour profile has not been approved",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin:
                          EdgeInsets.fromLTRB(20, 0, 20, 80 * (height / width)),
                      color: Color.fromRGBO(249, 175, 25, 1),
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Your Profile in under review. We will let you know after your profile get verified",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        authToken.setToken(null);
                        final _storage = FlutterSecureStorage();
                        await _storage.deleteAll();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                            (route) {
                          return route == Profile() ? true : false;
                        });
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
          ],
        ),
      ),
    );
  }
}
