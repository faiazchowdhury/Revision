import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:revised_quickassist/Model/listOfInfo.dart';
import 'package:revised_quickassist/Model/serviceProviderInfo.dart';
import 'package:revised_quickassist/UI/AllPages/PendingReview.dart';
import 'package:revised_quickassist/UI/AllPages/ProfileTab/Profile.dart';
import 'package:revised_quickassist/Widgets/SomethingWentWrong.dart';
import 'package:revised_quickassist/bloc/Bloc/profile_bloc.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'AvailabilityTab/Availability.dart';
import 'HomePageTab/HomePage.dart';
import 'MyWorkTab/MyWork.dart';
import 'ServicesTab/Services.dart';

class TabSelector extends StatefulWidget {
  final bool runLoader;
  final int initialPage;
  final int initialSubPage;
  TabSelector(this.runLoader, this.initialPage, this.initialSubPage);

  TabSelectorState createState() {
    return new TabSelectorState();
  }
}

class TabSelectorState extends State<TabSelector> {
  GlobalKey globalKey = new GlobalKey();
  List<Widget> pageList = List<Widget>();
  int _selectedPage;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> initState() {
    _selectedPage = widget.initialPage;
    if (widget.runLoader) {
      bloc.add(getInfo());
    }
    //controllerSetter();
    pageList.add(HomePage());
    pageList.add(MyWork());
    pageList.add(Availability());
    pageList.add(Services(widget.initialSubPage));
    pageList.add(Profile());
    super.initState();
  }

  PersistentTabController _controller;
  final bloc = new ProfileBloc();

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        MediaQuery.of(context).padding.top;
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return loader();
        } else if (state is ProfileInitial) {
          return viewScreen();
        } else if (state is ProfileLoadedwithResponse) {
          if (state.code == 200) {
            return viewScreen();
          } else if (state.code == 403) {
            return PendingReview();
          } else {
            return SomethingWentWrong();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget loader() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Quick Assist.png",
            scale: 3,
          ),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget viewScreen() {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0.25,
                blurRadius: 3,
                offset: Offset(0, -5), // changes position of shadow
              ),
            ],
          ),
          child: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.pinned,
            currentIndex: _selectedPage,
            backgroundColor: Colors.white,
            snakeShape: SnakeShape.indicator,
            selectedItemColor: Color.fromRGBO(129, 187, 46, 1),
            unselectedItemColor: Color.fromRGBO(101, 101, 101, 1),
            snakeViewColor: Color.fromRGBO(129, 187, 46, 1),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle:
                TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
            unselectedLabelStyle:
                TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
            shadowColor: Colors.black,
            onTap: (pageNumber) {
              setState(() {
                if (pageNumber == 0 && serviceProviderInfo.visible) {
                  pageList.removeAt(0);
                  pageList.insert(0, HomePage());
                }
                _selectedPage = pageNumber;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Column(children: [
                    SvgPicture.asset(
                      "assets/home.svg",
                      color: _selectedPage == 0
                          ? Color.fromRGBO(129, 187, 46, 1)
                          : Color.fromRGBO(101, 101, 101, 1),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ]),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Column(children: [
                    SvgPicture.asset(
                      "assets/clipboard.svg",
                      color: _selectedPage == 1
                          ? Color.fromRGBO(129, 187, 46, 1)
                          : Color.fromRGBO(101, 101, 101, 1),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ]),
                  label: "My Work"),
              BottomNavigationBarItem(
                icon: Column(children: [
                  SvgPicture.asset(
                    "assets/calendar (1).svg",
                    color: _selectedPage == 2
                        ? Color.fromRGBO(129, 187, 46, 1)
                        : Color.fromRGBO(101, 101, 101, 1),
                  ),
                  SizedBox(
                    height: 3,
                  )
                ]),
                label: "Availability",
              ),
              BottomNavigationBarItem(
                  icon: Column(children: [
                    SvgPicture.asset(
                      "assets/briefcase.svg",
                      color: _selectedPage == 3
                          ? Color.fromRGBO(129, 187, 46, 1)
                          : Color.fromRGBO(101, 101, 101, 1),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ]),
                  label: "Services"),
              BottomNavigationBarItem(
                  icon: Column(children: [
                    SvgPicture.asset(
                      "assets/user.svg",
                      color: _selectedPage == 4
                          ? Color.fromRGBO(129, 187, 46, 1)
                          : Color.fromRGBO(101, 101, 101, 1),
                    ),
                    SizedBox(
                      height: 3,
                    )
                  ]),
                  label: "Profile")
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: pageList,
      ),
    );
  }
}
