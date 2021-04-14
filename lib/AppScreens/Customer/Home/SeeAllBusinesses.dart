import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:review_app/AppScreens/Admin/Business/DetailsScreen.dart';
import 'package:review_app/AppScreens/Customer/ReviewCategory/SelectReviewCategory.dart';
import 'package:review_app/Controllers/BusinessController.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';
import 'package:review_app/dbhelper.dart';
import 'OfflineFeedback.dart';

class ClientSeeAllBusinesses extends StatefulWidget {
  @override
  _ClientSeeAllBusinessesState createState() => _ClientSeeAllBusinessesState();
}

class _ClientSeeAllBusinessesState extends State<ClientSeeAllBusinesses> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final businessController=Get.put(BusinessController());

  @override
  void initState() {
     new dbhelper().getFeedBacks().then((value){
       locator<Logger>().i(value);
     });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Business",
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: ()async{
          return Utils.check_connectivity().then((isConnected){
            if(isConnected){
              businessController.getBusinessForCustomer(context);
            }else{
              Utils.showError(context,"Network not Available");
            }
          });
        },
        child: Container(
            color: color4,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:Obx((){
              return
                ListView.builder(itemCount:businessController.businesses!=null?businessController.businesses.length:0  ,itemBuilder:(context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(business: businessController.businesses[index])));
                      },

                      child: Container(

                        width: MediaQuery.of(context).size.width,
                        height: 210,
                        decoration: BoxDecoration(
                          //border: Border.all(color: color1, width: 2)
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                              Card(
                                elevation: 6,
                                //color: color3,
                                child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:  NetworkImage(
                                            businessController.businesses!=null&&businessController.businesses[index].image!=null?businessController.businesses[index].image:''
                                        ),
                                      ),
                                      //color: color3,
                                      //borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black87,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            width: 65,
                                            height: 30,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons.solidStar,
                                                    color: Colors.amber,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 2,),
                                                  Text(businessController.businesses[index].overallRating.toStringAsFixed(1),
                                                    style: TextStyle(
                                                        color: color4,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ),
                            Positioned(
                              top: 23,
                              left: 110,
                              child: Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Container(
                                  height: 160,
                                  width: 280,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    //border: Border.all(color: color3, width: 1)
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 280,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              FaIcon(FontAwesomeIcons.utensils, color: color1, size: 20,),
                                              SizedBox(width: 3,),
                                              Text("Business: ",
                                                style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: color3,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 2,),
                                              Container(
                                                width: 140,
                                                child:
                                                Text(businessController.businesses!=null?businessController.businesses[index].name:'-',
                                                    //storeList[index].name!=null?storeList[index].name:"",
                                                    maxLines: 1 ,
                                                    style: GoogleFonts.prompt(
                                                      textStyle: TextStyle(
                                                          color: color1,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                    overflow: TextOverflow.ellipsis),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.mapMarkedAlt, color: color1, size: 20,),
                                            SizedBox(width: 3,),
                                            Text("Address: ",
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color3,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2,),
                                            Container(
                                              width: 150,
                                              child: Text(businessController.businesses!=null&&businessController.businesses[index].address!=null?businessController.businesses[index].address:'-',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: color1,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.building, color: color1, size: 20,),
                                            SizedBox(width: 3,),
                                            Text("Business Type: ",
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color3,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2,),
                                            Text(businessController.businesses!=null&&businessController.businesses[index].businessType!=null?businessController.businesses[index].businessType.name:'-',
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color1,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.clock, color: color1, size: 20,),
                                            SizedBox(width: 3,),
                                            Text("Opening: ",
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color3,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3,),
                                            Text(businessController.businesses!=null&&businessController.businesses[index].openingTime!=null?businessController.businesses[index].openingTime:'-',
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color1,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            FaIcon(FontAwesomeIcons.clock, color: color1, size: 20,),
                                            SizedBox(width: 3,),
                                            Text("Closing: ",
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color3,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 3,),
                                            Text(businessController.businesses!=null&&businessController.businesses[index].closingTime!=null?businessController.businesses[index].closingTime:'-',
                                              style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                                    color: color1,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500
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
                          ],
                        ),
                      ),
                    ),
                  );
                });
            })
        ),
      ),
    );
  }
}
class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 2/3, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}

