import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:review_app/AppScreens/Admin/LocationSetting/Address.dart';
import 'package:review_app/AppScreens/Admin/LocationSetting/Location.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Controllers/BusinessController.dart';
import 'package:review_app/Models/BusinessViewModel.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Models/BusinessViewModel.dart';


class AddBusiness extends StatefulWidget {
  var type;

  AddBusiness(this.type);

  @override
  _AddBusinessState createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {

  Address Businessaddress;
  File _image;
  DateTime start_time ;
  DateTime end_time ;
  TextEditingController time=TextEditingController();
  var _formKey = new GlobalKey<FormState>();
  final businessController=Get.put(BusinessController());
  final accountController = Get.find<AccountController>();
  @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Business",
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8,
                        color: color6,
                        child: Container(
                          child: TextFormField(
                            controller: businessController.nameTextEditingController,
                            style:  GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color1,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            obscureText: false,
                            validator: (String value) =>
                            value.isEmpty ? "This field is Required" : null,
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
                            controller: businessController.phoneTextEditingController,
                            style:  GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color1,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            obscureText: false,
                            validator: (String value) =>
                            value.isEmpty ? "This field is Required" : null,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: color3, width: 1.0)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: color6, width: 1.0)
                              ),
                              labelText: "Contact Number",
                              labelStyle: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color3,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child:  Card(
                        elevation: 8,
                        color: color6,
                        child: Container(
                          child: ListTile(
                            title: TextFormField(
                              controller: businessController.addressTextEditingController,
                              style: TextStyle(color: color1,fontWeight: FontWeight.bold),
                              obscureText: false,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: color3, width: 1.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: color3, width: 1.0)
                                ),
                                labelText:  "Address",
                                labelStyle: TextStyle(color: color3, fontWeight: FontWeight.bold),
                              ),
                              textInputAction: TextInputAction.next,

                            ),
                            trailing: InkWell(
                                onTap: () async{
                                  Businessaddress = await Navigator.push(context, MaterialPageRoute(builder: (context) => Location(),),);
                                  businessController.addressTextEditingController.text = Businessaddress.address;
                                  businessController.longitude.value=Businessaddress.longitude;
                                  businessController.latitude.value=Businessaddress.latitude;
                                },
                                child: Icon(Icons.add_location,color: color3,size: 35,)),
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
                            controller: businessController.emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
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
                                  borderSide: BorderSide(color:color6, width: 1.0)
                              ),
                              labelText: "Email",
                              labelStyle: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color3,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
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
                            controller: businessController.descriptionTextEditingController,
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
                              labelText: "Description",
                              labelStyle: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color3,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
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
                          decoration: BoxDecoration(
                            //color: Colors.white12,
                            borderRadius: BorderRadius.circular(9),
                            //border: Border.all(color: color1, width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: businessController.startTime,
                              style: Theme.of(context).textTheme.bodyText1,
                              //inputType: InputType.time,
                              //alwaysUse24HourFormat: true,
                              //format: DateFormat("HH:mm:ss"),
                              onTap: ()async{
                                FocusScope.of(context).requestFocus(new FocusNode());
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                                );
                                businessController.openingTime.value=DateFormat("hh:mm").parse(time.hour.toString()+":"+time.minute.toString());
                                businessController.startTime.text=time.hour.toString()+":"+time.minute.toString();
                              },
                              // onShowPicker: (context, currentValue) async {
                              //   final time = await showTimePicker(
                              //     context: context,
                              //     initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              //   );
                              //
                              //   return DateTimeField.convert(time);
                              // },
                              decoration: InputDecoration(labelText: "Select start time",
                                labelStyle: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    color: color3,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color: color1, width: 2.0)
                                ),),
                              onChanged: (value){
                                setState(() {businessController.openingTime.value=DateFormat("hh:mm").parse(value);
                                  this.start_time=DateFormat("hh:mm:ss").parse(value);
                                });
                              },
                            ),
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
                          decoration: BoxDecoration(
                            //color: Colors.white12,
                            borderRadius: BorderRadius.circular(9),
                            //border: Border.all(color: color1, width: 2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: businessController.endTime,
                              style: Theme.of(context).textTheme.bodyText1,
                              // alwaysUse24HourFormat: true,
                             // format: DateFormat("HH:mm:ss"),
                              onTap: ()async{
                                FocusScope.of(context).requestFocus(new FocusNode());
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                                );
                                businessController.closingTime.value=DateFormat("hh:mm").parse(time.hour.toString()+":"+time.minute.toString());
                                businessController.endTime.text=time.hour.toString()+":"+time.minute.toString();
                              },
                              // onShowPicker: (context, currentValue) async {
                              //
                              //
                              //   return DateTimeField.convert(time);
                              // },
                              decoration: InputDecoration(labelText: "Select end time",
                                labelStyle: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: color3,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0),
                                    borderSide: BorderSide(color:color1, width: 2.0)
                                ),),
                              onChanged: (value){
                                setState(() {
                                  this.end_time=DateFormat("HH:mm").parse(value);
                                  businessController.closingTime.value=DateFormat("HH:mm").parse(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                          ),
                        ),

                      ) : Image.file(_image),
                    ),
                    MaterialButton(
                      color: color3,
                      onPressed: (){
                        Utils.getImage().then((image_file){
                          if(image_file!=null){
                            image_file.readAsBytes().then((image){
                              if(image!=null){
                                businessController.image.value=base64Encode(image);
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
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){

                   // businessController.addBusiness(context);
                  if(widget.type=="SignUp") {
                    accountController.RegisterUser(context, BusinessViewModel(
                      description: businessController
                          .descriptionTextEditingController.text,
                      email: businessController.emailTextEditingController.text,
                      ownerId: "Acx",
                      isVisible: true,
                      businessTypeId: 1,
                      longitude: businessController.longitude.value,
                      latitude: businessController.latitude.value,
                      address: businessController.addressTextEditingController
                          .text,
                      image: businessController.image.value,
                      name: businessController.nameTextEditingController.text,
                      closingTime: DateFormat("HH:mm:ss").format(
                          businessController.closingTime.value),
                      openingTime: DateFormat("HH:mm:ss").format(
                          businessController.openingTime.value),
                      phone: businessController.phoneTextEditingController.text,
                    )).then((value){
                      businessController.descriptionTextEditingController.text="";
                      businessController.emailTextEditingController.text="";
                      businessController.addressTextEditingController.text="";
                      businessController.image.value="";
                      businessController.nameTextEditingController.text="";
                      businessController.phoneTextEditingController.text="";
                      businessController.closingTime.value=null;
                      businessController.openingTime.value=null;
                      businessController.longitude.value=0.0;
                      businessController.latitude.value=0.0;
                    });
                  }else if(widget.type=="loggedIn"){
                    businessController.addBusiness(context);
                  }
                },
                child: Center(
                  child: Card(
                    elevation: 8,
                    color: color3,
                    child: Container(
                      height: 55,
                      width: 220,
                      decoration: BoxDecoration(
                        //color: color3,
                        borderRadius: BorderRadius.circular(10),
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
              SizedBox(height: 20,)
            ],
          ),
        ),
      )
    );
  }
}
