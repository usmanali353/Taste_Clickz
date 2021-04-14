import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/WelcomeScreens/NewSplashScreen.dart';
import 'package:review_app/components/OnBoardingAnimation.dart';
import 'package:review_app/components/colorConstants.dart';
import 'package:slider_button/slider_button.dart';

class NewOnboarding extends StatefulWidget {
  @override
  _NewOnboardingState createState() => _NewOnboardingState();
}

class _NewOnboardingState extends State<NewOnboarding> with SingleTickerProviderStateMixin{

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
    return Scaffold(

      body: Container(
        color: color1,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:90,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 100,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 27, 28, 30),
                        boxShadow: [BoxShadow(
                            color: Colors.red,
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value
                        )
                        ]
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.sentiment_dissatisfied, color: Colors.redAccent, size: 100,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 27, 28, 30),
                        boxShadow: [BoxShadow(
                            color: Colors.redAccent,
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value
                        )
                        ]
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.sentiment_neutral, color: Colors.amber, size: 100,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 27, 28, 30),
                        boxShadow: [BoxShadow(
                            color: Colors.amber,
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value
                        )
                        ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.sentiment_satisfied, color: Colors.lightGreen, size: 100,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 27, 28, 30),
                        boxShadow: [BoxShadow(
                            color: Colors.lightGreen,
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value
                        )
                        ]
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 100,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 27, 28, 30),
                        boxShadow: [BoxShadow(
                            color: Colors.green,
                            blurRadius: _animation.value,
                            spreadRadius: _animation.value
                        )
                        ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Center(
                  child:
                  Text("Welcome To TasteClicks",
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color3,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("TasteClicks empowers participating Better Business Bureau accredited businesses to request customer reviews at the point of service. \n From TasteClicks, customers receive a text and submit their review directly to the participating Better Business Bureaus.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color4,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
          // Center(
          //     child: SliderButton(
          //       backgroundColor: color3,
          //   buttonColor: color1,
          //   action: () {
          //     ///Do something here
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=> NewSplashScreen()));
          //   },
          //   label: Text(
          //     "Slide to Enter",
          //     style: TextStyle(
          //         color: color1, fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          //   icon: FaIcon(FontAwesomeIcons.arrowRight, color: color3,)
          //
          //
          // )),
              SizedBox(height: 30),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NewSplashScreen()));
                  },
                  child: Card(
                    color: color3,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Getting Started",
                              style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color4,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            FaIcon(FontAwesomeIcons.arrowCircleRight, color: color4, size: 30,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
