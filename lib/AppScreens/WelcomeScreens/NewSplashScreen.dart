
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/Customer/Home/SeeAllBusinesses.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/AppScreens/WelcomeScreens/LoginScreen.dart';
import 'package:review_app/AppScreens/WelcomeScreens/RegisterScreen.dart';

import 'package:review_app/components/colorConstants.dart';

import 'RegisterBusiness.dart';

class NewSplashScreen extends StatefulWidget {
  @override
  _NewSplashScreenState createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: color4,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ClipPath(
                  clipper: WaveClipperTwo(flip: true),
                  child: Container(
                    height: 125,
                    color: color5,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: WaveClipperTwo(flip: true),
                          child: Container(
                            height: 110,
                            color: color3,
                            //child: Center(child: Text("WaveClipperTwo(flip: true)")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(

                      image: AssetImage('assets/tasteclicks.png')
                    )
                  ),
                )
              ),
              SizedBox(height: 90,),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterBusiness()));
                  },
                  child: Container(
                    height: 60,
                    width: 310,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color3
                        //border: Border.all(color: color3, width: 2)
                    ),
                    child: Center(
                      child: Text("Register Business",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color4,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen("Customer")));
                  },
                  child: Container(
                    height: 60,
                    width: 310,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: color3, width: 2)
                    ),
                    child: Center(
                      child: Text("Sign Up",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color3,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: InkWell(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: 310,
                    decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(15),
                        //border: Border.all(color: color3, width: 2)
                    ),
                    child: Center(
                      child: Text("Sign In",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color4,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: TextButton(
                  child: Text("Login as Guest",
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                      color: color3,
                      fontSize: 20,
                          decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold
                  ),
                ),),
                  onPressed: (){
                    locator<GetStorage>().remove("token");
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ClientSeeAllBusinesses()));
                  },
                ),
              ),
              // SizedBox(height: 50,),
              // RotationTransition(
              //   turns: new AlwaysStoppedAnimation(180 / 360),
              //   child: Container(
              //     child: ClipPath(
              //       clipper: WaveClipperTwo(flip: true),
              //       child: Container(
              //         height: 115,
              //         color: color5,
              //         child: Stack(
              //           children: [
              //             ClipPath(
              //               clipper: WaveClipperTwo(flip: true),
              //               child: Container(
              //                 height: 100,
              //                 color: color3,
              //                 //child: Center(child: Text("WaveClipperTwo(flip: true)")),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}





class WaveClipperTwo extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  WaveClipperTwo({this.reverse = false, this.flip = false});

  @override
  Path getClip(Size size) {
    var path = Path();
    if (!reverse && !flip) {
      path.lineTo(0.0, size.height - 20);

      var firstControlPoint = Offset(size.width / 4, size.height);
      var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondControlPoint =
      Offset(size.width - (size.width / 3.25), size.height - 65);
      var secondEndPoint = Offset(size.width, size.height - 40);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);

      path.lineTo(size.width, size.height - 40);
      path.lineTo(size.width, 0.0);
      path.close();
    } else if (!reverse && flip) {
      path.lineTo(0.0, size.height - 40);
      var firstControlPoint = Offset(size.width / 3.25, size.height - 65);
      var firstEndPoint = Offset(size.width / 1.75, size.height - 20);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondCP = Offset(size.width / 1.25, size.height);
      var secondEP = Offset(size.width, size.height - 30);
      path.quadraticBezierTo(
          secondCP.dx, secondCP.dy, secondEP.dx, secondEP.dy);

      path.lineTo(size.width, size.height - 20);
      path.lineTo(size.width, 0.0);
      path.close();
    } else if (reverse && flip) {
      path.lineTo(0.0, 20);
      var firstControlPoint = Offset(size.width / 3.25, 65);
      var firstEndPoint = Offset(size.width / 1.75, 40);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondCP = Offset(size.width / 1.25, 0);
      var secondEP = Offset(size.width, 30);
      path.quadraticBezierTo(
          secondCP.dx, secondCP.dy, secondEP.dx, secondEP.dy);

      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
      path.close();
    } else {
      path.lineTo(0.0, 20);

      var firstControlPoint = Offset(size.width / 4, 0.0);
      var firstEndPoint = Offset(size.width / 2.25, 30.0);
      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
          firstEndPoint.dx, firstEndPoint.dy);

      var secondControlPoint = Offset(size.width - (size.width / 3.25), 65);
      var secondEndPoint = Offset(size.width, 40);
      path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
          secondEndPoint.dx, secondEndPoint.dy);

      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
