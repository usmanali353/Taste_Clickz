import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/WelcomeScreens/NewSplashScreen.dart';
import 'package:review_app/components/OnBoardingAnimation.dart';
import 'package:review_app/components/colorConstants.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: color4,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/review.jpg')
          //   )
          // ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.cover,
                    //         image: AssetImage('assets/review.jpg')
                    //     )
                    // ),
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width,
                    child: OnBoardingAnimation(),
                  )
                ],
              ),
              Positioned(
                top: 340,
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(180 / 360),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ClipPath(
                      clipper: WaveClipperTwo(flip: true),
                      child: Container(
                        height: 165,
                        color: color5,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: WaveClipperTwo(flip: true),
                              child: Container(
                                height: 150,
                                color: color3,
                                child: RotationTransition(
                                  turns: new AlwaysStoppedAnimation(180 / 360),
                                  child:
                                  Center(
                                      child:
                                  Text("Welcome To TasteClicks",
                                    style: GoogleFonts.prompt(
                                      textStyle: TextStyle(
                                          color: color1,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 480,
                child: Container(
                  color: color3,
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text("TasteClicks empowers participating Better Business Bureau accredited businesses to request customer reviews at the point of service. \n From TasteClicks, customers receive a text and submit their review directly to the participating Better Business Bureaus.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewSplashScreen()));
                          },
                          child: Card(
                            color: color1,
                            elevation: 8,
                            child: Container(
                              height: 60,
                              width: 310,
                              decoration: BoxDecoration(
                                //color: color1,
                                borderRadius: BorderRadius.circular(17),
                                //border: Border.all(color: color3, width: 2)
                              ),
                              child: Center(
                                child: Text("Getting Started...",
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
class WaveClipperOne extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  WaveClipperOne({this.reverse = false, this.flip = false});

  @override
  Path getClip(Size size) {
    if (!reverse && !flip) {
      Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
      Offset firstControlPoint = Offset(size.width * .25, size.height - 30);
      Offset secondEndPoint = Offset(size.width, size.height - 50);
      Offset secondControlPoint = Offset(size.width * .75, size.height - 10);

      final path = Path()
        ..lineTo(0.0, size.height)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    } else if (!reverse && flip) {
      Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
      Offset firstControlPoint = Offset(size.width * .25, size.height - 10);
      Offset secondEndPoint = Offset(size.width, size.height);
      Offset secondControlPoint = Offset(size.width * .75, size.height - 30);

      final path = Path()
        ..lineTo(0.0, size.height - 30)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    } else if (reverse && flip) {
      Offset firstEndPoint = Offset(size.width * .5, 20);
      Offset firstControlPoint = Offset(size.width * .25, 10);
      Offset secondEndPoint = Offset(size.width, 0);
      Offset secondControlPoint = Offset(size.width * .75, 30);

      final path = Path()
        ..lineTo(0, 30)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    } else {
      Offset firstEndPoint = Offset(size.width * .5, 20);
      Offset firstControlPoint = Offset(size.width * .25, 30);
      Offset secondEndPoint = Offset(size.width, 50);
      Offset secondControlPoint = Offset(size.width * .75, 10);

      final path = Path()
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
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
