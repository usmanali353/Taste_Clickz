import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:review_app/AppScreens/Admin/Business/DetailsScreen.dart';
import 'package:review_app/Interfaces/IBusinessRepository.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:share/share.dart';
import 'package:http/http.dart'as http;

class Utils{
   static String baseUrl(){
    // return "https://foodbooks.conveyor.cloud/api/";
     //return "http://192.168.1.14:45459/api/";
     return "http://iibtechnology-001-site1.dtempurl.com/api/";
   }
   static bool validateStructure(String value){
     RegExp regExp = new RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{6,}$');
     return regExp.hasMatch(value);
   }
   static bool validateEmail(String value){
     RegExp regExp=  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
     return regExp.hasMatch(value);
   }
   static Future<bool> check_connectivity () async{
     bool result = await DataConnectionChecker().hasConnection;
     return result;
   }
   static dynamic myEncode(dynamic item){
     if(item is DateTime)
       return item.toIso8601String();
   }
   static void showSuccess(BuildContext context,String message){
     Flushbar(
       backgroundColor: Colors.green,
       duration: Duration(seconds: 3),
       message: message,
     ).show(context);

   }
   static void showError(BuildContext context,String message){
     Flushbar(
       backgroundColor: Colors.red,
       duration: Duration(seconds: 3),
       message: message,
     ).show(context);
   }
   static Map<String, dynamic> parseJwt(String token) {
     final parts = token.split('.');
     if (parts.length != 3) {
       throw Exception('invalid token');
     }

     final payload = _decodeBase64(parts[1]);
     final payloadMap = json.decode(payload);
     if (payloadMap is! Map<String, dynamic>) {
       throw Exception('invalid payload');
     }

     return payloadMap;
   }
   static String _decodeBase64(String str) {
     String output = str.replaceAll('-', '+').replaceAll('_', '/');

     switch (output.length % 4) {
       case 0:
         break;
       case 2:
         output += '==';
         break;
       case 3:
         output += '=';
         break;
       default:
         throw Exception('Illegal base64url string!"');
     }

     return utf8.decode(base64Url.decode(output));
   }
   static String getQuestionType(int id){
     if(id==1){
       return "Star Rating";
     }else if(id==2){
       return "Yes/No";
     }else if(id==3){
       return "Radio Button";
     }
   }
   static Future<File> getImage() async {
     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
     return image;
   }
   static Future<File> getImageCamera() async {
     var image = await ImagePicker.pickImage(source: ImageSource.camera);
     return image;
   }
   static Future<File> urlToFile(BuildContext context,String imageUrl) async {
     ArsProgressDialog pd = ArsProgressDialog(
         context,
         blur: 2,
         backgroundColor: Color(0x33000000),
         animationDuration: Duration(milliseconds: 500));
     pd.show();
     try{
       var rng = new Random();

       Directory tempDir = await getTemporaryDirectory();

       String tempPath = tempDir.path;

       File file = new File('$tempPath'+ (rng.nextInt(10000)).toString() +'.png');

       http.Response response = await http.get(imageUrl);
       if(response.statusCode==200){
         pd.dismiss();
         await file.writeAsBytes(response.bodyBytes);
       }else{
         pd.dismiss();
         Utils.showError(context, response.statusCode.toString());
       }
       return file;
     }catch(e){
       pd.dismiss();
       print(e.toString());
     }
     return null;
   }
   static void shareImage(BuildContext context,Uint8List pngBytes) async{
     try{
       var rng = new Random();

       Directory tempDir = await getTemporaryDirectory();

       String tempPath = tempDir.path;

       File file = new File('$tempPath'+ (rng.nextInt(10000)).toString() +'.png');

       await file.writeAsBytes(pngBytes);
       Share.shareFiles([file.path], text:"Please Scan this qr code to get details");
     }catch(e){
       showError(context,e.toString());
     }
   }
   static Future scan(BuildContext context) async {
     String  barcode;
     try {
       String result = await FlutterBarcodeScanner.scanBarcode(
           "#ff6666",
           "Cancel",
           true,
           ScanMode.DEFAULT);
       barcode = result;
       if (barcode != "" && barcode.length > 0) {
          locator<IBusinessRepository>().getBusinessById(int.parse(barcode), context).then((business){
            if(business!=null){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(business: business,)));
            }else{
              showError(context,"No Business Data Found");
            }
          });
       }
     } catch (e) {
       Flushbar(
         message: e,
         backgroundColor: Colors.red,
         duration: Duration(seconds: 5),
       ).show(context);
     }
     return barcode;
   }
   static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
     dynamic data;
     if (message.containsKey('data')) {
       // Handle data message
       data = message['data'];
     }

     if (message.containsKey('notification')) {
       // Handle notification message
       data = message['notification'];
     }
     print(data.toString());
     return data;
     // Or do other work.
   }
}