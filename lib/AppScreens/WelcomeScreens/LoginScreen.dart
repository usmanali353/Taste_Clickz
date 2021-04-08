import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/WelcomeScreens/ForgotPassword.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/components/colorConstants.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final  accountController = Get.put(AccountController());
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
                    height: 135,
                    color: color5,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: WaveClipperTwo(flip: true),
                          child: Container(
                            height: 120,
                            color: color3,
                            child:Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.arrow_back, color: color6,size:30),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child:Container(
                  width: 400,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/tasteclicks.png')
                      )
                  ),
                )
              ),
              SizedBox(height: 20,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 400,
                    height: 240,
                    decoration: BoxDecoration(
                      color: color4,
                      borderRadius: BorderRadius.circular(10),
                      //color: color3,
                      // border: Border.all(
                      //     color: color3,
                      //     width: 2
                      // )
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'WELCOME...',
                              style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color1,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 8,
                            color: color4,
                            child: Container(
                              child: TextFormField(
                                controller: accountController.emailTextEditingController,
                                style:  GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: color1,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                obscureText: false,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: color3, width: 1.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: color6, width: 1.0)
                                  ),
                                  labelText: "Email",
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  suffixIcon: Icon(Icons.email,color: color3,size: 27,),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 8,
                            color: color4,
                            child: Container(
                              child: TextFormField(
                                controller: accountController.passwordTextEditingController,
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: color1,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: color3, width: 1.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: color6, width: 1.0)
                                  ),
                                  labelText: "Password",
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  suffixIcon: IconButton(icon: Icon(accountController.isVisible?Icons.visibility:Icons.visibility_off,color: color3,size: 27),onPressed: () {

                                  },),//(Icons.https,color: yellowColor,size: 27,)
                                ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: (){
                    if(accountController.emailTextEditingController.text==null||accountController.emailTextEditingController.text.isEmpty){
                      Utils.showError(context, "Email is Required");
                    }else if(!Utils.validateEmail(accountController.emailTextEditingController.text)){
                      Utils.showError(context, "Email Format is Invalid");
                    }
                    else if(accountController.passwordTextEditingController.text==null||accountController.passwordTextEditingController.text.isEmpty){
                      Utils.showError(context, "Password is Required");
                    }else if(!Utils.validateStructure(accountController.passwordTextEditingController.text)){
                      Utils.showError(context, "Password must contain atleast one lower case,Upper case and special characters");
                    }else{
                      accountController.AuthenticateUser(context);
                      //locator<IBusinessRepository>().getBusinessByOwner(context);
                    }
                  },
                  child: Center(
                    child: Card(
                      elevation: 8,
                      color: color3,
                      child: Container(
                        height: 55,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          //border: Border.all(color: Color(0xfbb55400), width: 3)
                        ),
                        child: Center(
                          child: Text("Sign In",
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color4,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                              color: color1,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
              ),
              // SizedBox(height: 20,),
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
