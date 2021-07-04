import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revised_quickassist/Model/profilePicture.dart';
import 'package:revised_quickassist/Widgets/loadingCircle.dart';
import 'package:revised_quickassist/bloc/Bloc/registrationmethods_bloc.dart';

class profilePictureUpload extends StatefulWidget {
  @override
  profilePictureUploadState createState() => profilePictureUploadState();
}

class profilePictureUploadState extends State<profilePictureUpload> {
  final bloc = new RegistrationmethodsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is RegistrationmethodsInitial) {
            return uploadPicture();
          } else if (state is RegistrationmethodsLoading) {
            return loadingCircle();
          } else if (state is RegistrationmethodsLoaded) {
            return uploadPicture();
          }
        });
  }

  Widget uploadPicture() {
    return Center(
      child: GestureDetector(
        onTap: () {
          bloc.add(uploadImage());
        },
        child: Container(
          child: profilePicture.getImg != null
              ? Image.file(
                  profilePicture.getImg,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fitHeight,
                )
              : DottedBorder(
                  padding: EdgeInsets.all(50),
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  color: Color.fromRGBO(117, 117, 117, 0.62),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(129, 187, 46, 1)),
                              borderRadius: BorderRadius.circular(50)),
                          width: 70,
                          height: 70,
                          child: Icon(
                            Icons.add,
                            color: Color.fromRGBO(129, 187, 46, 1),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Upload Photo",
                          style: TextStyle(
                            color: Color.fromRGBO(129, 187, 46, 1),
                            fontSize: 15,
                            decoration: TextDecoration.underline,
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
}
