import 'package:flutter/cupertino.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';

class AboutApp extends StatefulWidget {
  @override
  AboutAppState createState() => AboutAppState();
}

class AboutAppState extends State<AboutApp> {
  double width, height;
  final bloc = new ProfileBloc();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return Container();
  }
}
