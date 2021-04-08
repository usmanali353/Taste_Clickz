import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/components/colorConstants.dart';
import 'package:review_app/Utils/Utils.dart';

class CommentWithPicture extends StatefulWidget {
  var businessId,categoryId,subcategoryId,businessOwnerId,businessName;

  CommentWithPicture({this.businessId, this.categoryId, this.subcategoryId,this.businessOwnerId,this.businessName});

  @override
  _CommentWithPictureState createState() => _CommentWithPictureState();
}

class _CommentWithPictureState extends State<CommentWithPicture> {
  bool isVisible= true;
  File _image;

  @override
  Widget build(BuildContext context) {
    final _feedbackController=Get.find<FeedbackController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Comment & Picture",
          style: GoogleFonts.prompt(
            textStyle: TextStyle(
                color: color4,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: color4
        ),
        centerTitle: true,
        backgroundColor: color3,
      ),
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
                    height: 105,
                    color: color5,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: WaveClipperTwo(flip: true),
                          child: Container(
                            height: 90,
                            color: color3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 400,
                    height: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Card(
                          color: color4,
                          elevation:6,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _feedbackController.comment,
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: color1,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                obscureText: false,maxLines: 5,
                                // validator: (String value) =>
                                // value.isEmpty ? "This field is Required" : null,
                                decoration: InputDecoration(
                                  // suffixIcon: Icon(Icons.add_location,color: Colors.amberAccent,),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: color3, width: 1.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: color6, width: 1.0)
                                  ),
                                  labelText: 'Comment',
                                  labelStyle: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  //suffixIcon: Icon(Icons.email,color: Colors.amberAccent,size: 27,),
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(16),
                                height: 100,
                                width: 80,
                                child: _image == null ? Text('No image selected.',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ) : Image.file(_image),
                              ),
                              MaterialButton(
                                color: color3,
                                onPressed: (){
                                  Utils.getImageCamera().then((image_file){
                                    if(image_file!=null){
                                      image_file.readAsBytes().then((image){
                                        if(image!=null){
                                          _feedbackController.image=base64Encode(image);
                                          setState(() {
                                            _image = image_file;
                                          });
                                        }
                                      });
                                    }else{

                                    }
                                  });
                                },
                                child: Text("Select Image",
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color4,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                    _feedbackController.addFeedback(context, widget.businessId, widget.categoryId, widget.subcategoryId,widget.businessOwnerId,widget.businessName);
                  },
                  child: Center(
                    child: Card(
                      elevation: 8,
                      color: color3,
                      child: Container(
                        height: 55,
                        width: 250,
                        decoration: BoxDecoration(
                          //color: color1,
                          // gradient: new LinearGradient(
                          //     colors: [
                          //       Color(0xff222831), Color(0xff393e46)
                          //     ]
                          // ),
                          borderRadius: BorderRadius.circular(15),
                          //border: Border.all(color: Color(0xfbb55400), width: 3)
                        ),
                        child: Center(
                          child: Text("SAVE",
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
