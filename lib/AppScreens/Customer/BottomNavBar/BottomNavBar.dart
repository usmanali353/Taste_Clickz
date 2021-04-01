import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/IndividualFeedbacks.dart';
import 'package:review_app/AppScreens/Admin/Profile/ProfileScreen.dart';
import 'package:review_app/AppScreens/Customer/Home/SeeAllBusinesses.dart';

class ClientBottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<ClientBottomNavBar> {
  int currentPage = 1;
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
          TabData(
            iconData: Icons.question_answer,
            title: "Reviews",
          ),
          TabData(iconData: Icons.home, title: "Home",),

          TabData(iconData: Icons.assignment_ind, title: "Profile"),

        ],
        initialSelection: 1,
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
        return IndividualFeedbacks(businessId: 0,isAdmin: false,);
      case 1:
        return ClientSeeAllBusinesses();
      default:
        return ProfileScreen();
    }
  }
}