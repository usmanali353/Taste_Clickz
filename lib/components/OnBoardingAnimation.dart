import 'package:review_app/components/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class OnBoardingAnimation extends StatefulWidget {
  @override
  _NewOnBoardingScreenState createState() => _NewOnBoardingScreenState();
}

class _NewOnBoardingScreenState extends State<OnBoardingAnimation> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync:this,duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation =  Tween(begin: 2.0,end: 8.0).animate(_animationController)..addListener((){
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
            color: color1,
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
                )
              ],
            ),
          )
      ),
    );
  }
}
