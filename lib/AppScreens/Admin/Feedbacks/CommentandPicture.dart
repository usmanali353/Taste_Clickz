import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/components/colorConstants.dart';

class CommentAndPicture extends StatefulWidget {
  String comment,image;

  CommentAndPicture(this.comment, this.image);

  @override
  _CommentAndPictureState createState() => _CommentAndPictureState();
}

class _CommentAndPictureState extends State<CommentAndPicture> {

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
            decoration: BoxDecoration(
              color: color1,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.image!=null ?MemoryImage(base64Decode(widget.image)):AssetImage("assets/business.jpg")
              )
            ),
            ),
            Center(
              child: Card(
                elevation: 10,
                color: color4,
                child: Container(
                  decoration: BoxDecoration(
                    color: color4,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 320,
                  height: 260,
                  child: Column(
                    children: [
                      Text("Comments",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color3,
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(widget.comment!=null?widget.comment:"",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color1,
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )

          ],
        )
      ),
    );
  }
}
