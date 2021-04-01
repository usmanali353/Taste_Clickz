import 'package:review_app/AppScreens/WelcomeScreens/NewSplashScreen.dart';
import 'package:review_app/components/OnBoardingAnimation.dart';
import 'package:review_app/components/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NewOnBoardingScreen extends StatefulWidget {
  @override
  _NewOnBoardingScreenState createState() => _NewOnBoardingScreenState();
}

class _NewOnBoardingScreenState extends State<NewOnBoardingScreen> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync:this,duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation =  Tween(begin: 2.0,end: 10.0).animate(_animationController)..addListener((){
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 38, 38, 38),
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: color4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  child: OnBoardingAnimation(),
                ),
                Container(
                  color: color3,
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                ),
                // Stack(
                //   children: [
                //     Positioned(
                //       top: 340,
                //       child: RotationTransition(
                //         turns: new AlwaysStoppedAnimation(180 / 360),
                //         child: Container(
                //           width: MediaQuery.of(context).size.width,
                //           child: ClipPath(
                //             clipper: WaveClipperTwo(flip: true),
                //             child: Container(
                //               height: 165,
                //               color: color5,
                //               child: Stack(
                //                 children: [
                //                   ClipPath(
                //                     clipper: WaveClipperTwo(flip: true),
                //                     child: Container(
                //                       height: 150,
                //                       color: color3,
                //                       child: RotationTransition(
                //                         turns: new AlwaysStoppedAnimation(180 / 360),
                //                         child:
                //                         Center(
                //                             child:
                //                             Text("Welcome To TasteClicks",
                //                               style: GoogleFonts.prompt(
                //                                 textStyle: TextStyle(
                //                                     color: color1,
                //                                     fontSize: 30,
                //                                     fontWeight: FontWeight.bold
                //                                 ),
                //                               ),
                //                             )),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       top: 500,
                //       child: Container(
                //         color: color3,
                //         height: 400,
                //         width: MediaQuery.of(context).size.width,
                //         child: Column(
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Container(
                //                 child: Text("TasteClicks empowers participating Better Business Bureau accredited businesses to request customer reviews at the point of service. \n From TasteClicks, customers receive a text and submit their review directly to the participating Better Business Bureaus. \n The customer review is pre-verified and ready for publication once it has been processed by the local business.",
                //                   textAlign: TextAlign.center,
                //                   style: GoogleFonts.prompt(
                //                     textStyle: TextStyle(
                //                         color: color4,
                //                         fontSize: 13,
                //                         fontWeight: FontWeight.w500
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             SizedBox(height: 35,),
                //             Center(
                //               child: InkWell(
                //                 onTap: (){
                //                   Navigator.push(context, MaterialPageRoute(builder: (context)=> NewSplashScreen()));
                //                 },
                //                 child: Card(
                //                   color: color1,
                //                   elevation: 8,
                //                   child: Container(
                //                     height: 60,
                //                     width: 310,
                //                     decoration: BoxDecoration(
                //                       //color: color1,
                //                       borderRadius: BorderRadius.circular(17),
                //                       //border: Border.all(color: color3, width: 2)
                //                     ),
                //                     child: Center(
                //                       child: Text("Getting Started...",
                //                         style: GoogleFonts.prompt(
                //                           textStyle: TextStyle(
                //                               color: color4,
                //                               fontSize: 20,
                //                               fontWeight: FontWeight.bold
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        )
      ),
    );
  }
}
