
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:review_app/AppScreens/Admin/Business/BusinessList.dart';
import 'package:review_app/AppScreens/Admin/Profile/ProfileScreen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          // TabData(
          //   iconData:Icons.dashboard,
          //   title: "Dashboard",
          // ),
          // TabData(
          //   iconData: Icons.view_list,
          //   title: "Review",
          // ),
          TabData(iconData: Icons.home, title: "Home", ),
          TabData(iconData: Icons.account_box, title: "Profile"),
          //TabData(iconData: Icons.settings, title: "Settings"),

        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return BusinessList();
      //case 1:
       // return AdminHomeScreen();
      // case 2:
      //   return BusinessList();
      // case 2:
      //   return BusinessList();
      // case 3:
      //   return BusinessList();//AboutScreen();
      default:
        return ProfileScreen();
    }
  }
}