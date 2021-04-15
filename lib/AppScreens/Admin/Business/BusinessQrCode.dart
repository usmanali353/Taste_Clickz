import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:review_app/Models/BusinessViewModel.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class BusinessQRCode extends StatefulWidget {
  BusinessViewModel businessViewModel;

  BusinessQRCode(this.businessViewModel);

  @override
  _BusinessQRCodeState createState() => _BusinessQRCodeState();
}

class _BusinessQRCodeState extends State<BusinessQRCode> {
  GlobalKey globalKey = new GlobalKey();
  File logoimg;
  @override
 void initState(){
    Utils.check_connectivity().then((isConnected){
      if(isConnected){
        Utils.urlToFile(context,widget.businessViewModel.image).then((imageFile){
          setState(() {
            logoimg=imageFile;
          });
        });
      }else{
         Utils.showError(context,"Network Not Available");
      }
    });

    super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QRCode",
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
        actions: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(16),
                icon: Icon(Icons.print, color: color4,),
                onPressed: ()async{
                  final doc = pw.Document();

                  RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
                  var image = await boundary.toImage();
                  ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                  Uint8List pngBytes = byteData.buffer.asUint8List();
                  final PdfImage img = PdfImage.file(doc.document, bytes: pngBytes);
                  final PdfImage logo = PdfImage.file(doc.document, bytes: logoimg.readAsBytesSync());
                  doc.addPage(pw.Page(
                      build: (pw.Context context) {
                        return pw.Column(
                            children: [
                              pw.Padding(padding: pw.EdgeInsets.all(8.0)),
                              pw.Center(
                                child: pw.Image(pw.ImageProxy(logo),width: 100,height: 100),
                              ),
                              pw.Padding(padding: pw.EdgeInsets.only(bottom:20.0)),
                              pw.Center(
                                  child: pw.Text(widget.businessViewModel.name,style: pw.TextStyle(fontSize: 30,fontWeight: pw.FontWeight.bold))
                              ),
                              pw.Padding(padding: pw.EdgeInsets.only(bottom:20.0)),
                              pw.Center(
                                  child: pw.Image(pw.ImageProxy(img),width: 200,height: 200),
                              ),
                              pw.Padding(padding: pw.EdgeInsets.all(8.0)),
                              pw.Center(
                                  child: pw.Text("Scan this QR code to give review to this Restaurant",style: pw.TextStyle(fontSize: 20))
                              ),
                            ]
                        );
                      })); // Pa
                  await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => doc.save());
                },
              )
            ],
          )
        ],
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: widget.businessViewModel.id.toString(),
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          ),
        ],
      )
    );
  }
}
