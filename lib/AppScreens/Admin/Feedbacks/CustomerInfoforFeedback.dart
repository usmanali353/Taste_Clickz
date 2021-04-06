import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/AddRating.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/components/colorConstants.dart';

class CustomerInfoForFeedback extends StatefulWidget{
  var businessId,categoryId,subcategoryId,businessOwnerId,businessName;

  CustomerInfoForFeedback({this.businessId, this.categoryId, this.subcategoryId,this.businessOwnerId,this.businessName});

  @override
  _CustomerInfoForFeedbackState createState() => _CustomerInfoForFeedbackState();
}

class _CustomerInfoForFeedbackState extends State<CustomerInfoForFeedback> {
  final _feedbackController =Get.put(FeedbackController());
  final _accountController=Get.find<AccountController>();
  @override
  void initState() {
    if(_accountController.getLoggedInUserData()!=null){
      if(_accountController.getLoggedInUserData().userInfo.name!=null&&_accountController.getLoggedInUserData().userInfo.name.isNotEmpty){
        _feedbackController.name.text=_accountController.getLoggedInUserData().userInfo.name;
      }
      if(_accountController.getLoggedInUserData().userInfo.email!=null&&_accountController.getLoggedInUserData().userInfo.email.isNotEmpty){
        _feedbackController.email.text=_accountController.getLoggedInUserData().userInfo.email;
      }
      if(_accountController.getLoggedInUserData().userInfo.phone!=null&&_accountController.getLoggedInUserData().userInfo.phone.isNotEmpty){
        _feedbackController.phone.text=_accountController.getLoggedInUserData().userInfo.phone;
      }
      if(_accountController.getLoggedInUserData().userInfo.city!=null&&_accountController.getLoggedInUserData().userInfo.city.isNotEmpty){
        _feedbackController.city.text=_accountController.getLoggedInUserData().userInfo.city;
      }
      if(_accountController.getLoggedInUserData().userInfo.country!=null&&_accountController.getLoggedInUserData().userInfo.country.isNotEmpty){
        _feedbackController.country.text=_accountController.getLoggedInUserData().userInfo.country;
      }
    }
    super.initState();
  }
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
                    height: 165,
                    color: color5,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: WaveClipperTwo(flip: true),
                          child: Container(
                            height: 150,
                            color: color3,
                            child:Padding(
                              padding: const EdgeInsets.only(top: 60),
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
                child: Container(
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/tasteclicks.png')
                      )
                  ),
                )
              ),
              SizedBox(height: 10,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 400,
                    height: 510,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Want to Give Feedback?',
                              style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color1,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: color6,
                            child: Container(
                              child: TextFormField(
                                controller: _feedbackController.name,
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
                                  labelText: "Name",
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  suffixIcon: Icon(Icons.assignment_ind,color: color3,size: 27,),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: color6,
                            child: Container(
                              child: TextFormField(
                                controller: _feedbackController.email,
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
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: color6,
                            child: Container(
                              child: TextFormField(
                                controller: _feedbackController.phone,
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
                                  labelText: "Phone",
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  suffixIcon: Icon(Icons.add_call,color: color3,size: 27,),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: color6,
                            child: Container(
                              child: TextFormField(
                                controller: _feedbackController.city,
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
                                  labelText: "City",
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  suffixIcon: Icon(Icons.add_location_alt_outlined,color: color3,size: 27,),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: color6,
                            child: Container(
                              child: TextFormField(
                                controller: _feedbackController.country,
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
                                  labelText: "Country",
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  suffixIcon: Icon(Icons.account_balance,color: color3,size: 27,),
                                ),
                                textInputAction: TextInputAction.next,
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
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AddRatings(businessId: widget.businessId,categoryId: widget.categoryId,subcategoryId: widget.subcategoryId,businessOwnerId: widget.businessOwnerId,businessName: widget.businessName,)));
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
                        ),
                        child: Center(
                          child: Text("Proceed",
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