 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:review_app/AppScreens/Admin/Profile/EditProfile.dart';
import 'package:review_app/AppScreens/WelcomeScreens/NewSplashScreen.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/components/colorConstants.dart';



class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _accountController =Get.find<AccountController>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: color4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 310,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                    BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.edit, color: color3,size:30),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile()));
                                    },
                                  ),
                                  IconButton(
                                    icon:  FaIcon(FontAwesomeIcons.signOutAlt, color: color3, size: 25,),
                                    onPressed: (){
                                      FirebaseMessaging().unsubscribeFromTopic(_accountController.getLoggedInUserData().userInfo.id).then((value){
                                        locator<GetStorage>().remove("token");
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NewSplashScreen()), (route) => false);
                                      });

                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Row(
                              children: [
                                // Container(
                                //   width: 155.0,
                                //   height: 155.0,
                                //   decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: color3
                                //   ),
                                //   child: Stack(
                                //     children: [
                                //       Positioned(
                                //         top: 15,
                                //         child: Container(
                                //           width: 130.0,
                                //           height: 130.0,
                                //           decoration: BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: Colors.amberAccent.shade100,
                                //
                                //           ),
                                //           child:  CircleAvatar(
                                //             radius: 75,
                                //             backgroundColor: color2,
                                //             child: CircleAvatar(
                                //               backgroundImage: AssetImage('assets/image.jpg'),
                                //               //backgroundImage: NetworkImage(userDetail!=null?userDetail['image']:'http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg'),
                                //               radius: 70,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                SizedBox(width:25,),

                                Container(
                                  width: 350,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //color: color3,
                                    // border: Border.all(
                                    //   color: color3,
                                    //   width: 2
                                    // )
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null?_accountController.getLoggedInUserData().userInfo.name:'',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.prompt(
                                          textStyle: TextStyle(
                                              color: color3,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("as ",
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                  color: color4,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null&&_accountController.getLoggedInUserData().role!=null?_accountController.getLoggedInUserData().role:'',
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                  color: color3,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  Positioned(
                    top: 260,
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                            shape: CustomShapeBorder(),
                            color: color3
                        )
                    ),
                  ),
                ],
              ),
              RotationTransition(
                turns: new AlwaysStoppedAnimation(180 / 360),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: ShapeDecoration(
                        shape: CustomShapeBorder(),
                        color: color3
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 22,
                          left: 50,
                          child: Text("Name: ",
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: color3,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(
                                child: Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null?_accountController.getLoggedInUserData().userInfo.name:'',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 22,
                          left: 50,
                          child: Text("Email: ",
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: color3,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(
                                child: Container(
                                  width: 200,
                                  child: Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null?_accountController.getLoggedInUserData().userInfo.email:'',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.prompt(
                                      textStyle: TextStyle(
                                          color: color1,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 22,
                          left: 50,
                          child: Text("Contact: ",
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: color3,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(
                                child: Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null?_accountController.getLoggedInUserData().userInfo.phone:'',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 22,
                          left: 50,
                          child: Text("City: ",
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: color3,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(
                                child: Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null?_accountController.getLoggedInUserData().userInfo.city:'',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 22,
                          left: 50,
                          child: Text("Country: ",
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.7,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: color3,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Center(
                                child: Text(_accountController.getLoggedInUserData()!=null&&_accountController.getLoggedInUserData().userInfo!=null?_accountController.getLoggedInUserData().userInfo.country:'',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  const CustomShapeBorder();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => _getPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) => _getPath(rect);

  _getPath(Rect rect) {
    final r = rect.height / 2;
    final radius = Radius.circular(r);
    final offset = Rect.fromCircle(center: Offset.zero, radius: r);
    return Path()
      ..moveTo(rect.topLeft.dx, rect.topLeft.dy)
      ..relativeArcToPoint(offset.bottomRight, clockwise: false, radius: radius)
      ..lineTo(rect.center.dx - r, rect.center.dy)
      ..relativeArcToPoint(offset.bottomRight, clockwise: true, radius: radius)
      ..relativeArcToPoint(offset.topRight, clockwise: true, radius: radius)
      ..lineTo(rect.centerRight.dx - r, rect.centerRight.dy)
      ..relativeArcToPoint(offset.topRight, clockwise: false, radius: radius)
      ..addRect(rect);
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShapeBorder();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
  }
}