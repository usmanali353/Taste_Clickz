import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:review_app/AppScreens/Admin/Business/DetailsScreen.dart';
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
        title: Text("Restaurants",
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
          locator<GetStorage>().read("token")==null?Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
              padding: EdgeInsets.all(16),
              icon:Icon(Icons.feedback),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>OfflineFeedbacks()));
              },
              ),
              IconButton(
                padding: EdgeInsets.all(16),
                icon:Icon(FontAwesomeIcons.qrcode),
                onPressed: (){
                   Utils.scan(context);
                },
              )
            ],
          )
         :Container()
        ],
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: color4,
          child:Obx((){
            return ListView.builder(itemCount:businessController.businesses.length, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(business: businessController.businesses[index])));
                  },
                  child: Card(
                    elevation: 6,
                    color: color4,
                    child: Container(
                      width: 300,
                      height: 260,
                      decoration: BoxDecoration(
                        //color: color4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(businessController.businesses[index].image)
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right:10,
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
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                  color: color4,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.building, color: color1, size: 30,),
                                SizedBox(width: 5,),
                                Text(businessController.businesses[index].name,
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FaIcon(FontAwesomeIcons.mapMarkerAlt, color: color3, size: 30,),
                                SizedBox(width: 5,),
                                Container(
                                  width: 300,
                                  height: 50,
                                  child: Text(businessController.businesses[index].address!=null?businessController.businesses[index].address:"-",maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.prompt(
                                      textStyle: TextStyle(
                                          color: color1,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
