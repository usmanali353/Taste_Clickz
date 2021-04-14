import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:review_app/AppScreens/Admin/Business/AddBusiness.dart';
import 'package:review_app/AppScreens/Admin/Business/BusinessReport.dart';
import 'package:review_app/AppScreens/Admin/Business/BusinessQrCode.dart';
import 'package:review_app/AppScreens/Admin/BusinessCategory/BusinessCategoryList.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/IndividualFeedbacks.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Controllers/BusinessController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class BusinessList extends StatefulWidget {
  @override
  _BusinessListState createState() => _BusinessListState();
}

class _BusinessListState extends ResumableState<BusinessList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final businessController=Get.put(BusinessController());
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }


  @override
  void onResume() {
    if(resume.data=="Refresh"){
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _accountController =Get.find<AccountController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          _accountController.getLoggedInUserData().role=="Admin"?
          IconButton(
            icon: Icon(Icons.add, color: color4, size:35,),
            onPressed: (){
             // push(context, MaterialPageRoute(builder: (context)=> AddBusiness()));
              push(context, MaterialPageRoute(builder: (context)=> AddBusiness("loggedIn")));
            },
          ):Container()
        ],
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
              businessController.getBusinessByOwner(context);
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
              ListView.builder(itemCount:businessController.businesses!=null?businessController.businesses.length:0,itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 0,
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 245,
                              height: 218,
                              child:Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 220,
                                    child: Text(businessController.businesses!=null?businessController.businesses[index].name:'-',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.prompt(
                                        textStyle: TextStyle(
                                            color: color3,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 7,),
                                  Container(
                                    height: 20,
                                    width: 220,
                                    child:
                                    Text(businessController.businesses!=null&&businessController.businesses[index].address!=null?businessController.businesses[index].address:'-',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.prompt(
                                        textStyle: TextStyle(
                                            color: color1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 3,),
                                  RatingBar.builder(
                                    initialRating: double.parse(businessController.businesses[index].overallRating.toStringAsFixed(1)),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 10,
                                    ),
                                    // onRatingUpdate: (rating) {
                                    //   print(rating);
                                    // },
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        FaIcon(FontAwesomeIcons.clock, color: color1, size: 20,),
                                        SizedBox(width: 5,),
                                        Text("Open: ",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.prompt(
                                            textStyle: TextStyle(
                                                color: color3,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Text(businessController.businesses!=null?businessController.businesses[index].openingTime:'-',
                                          overflow: TextOverflow.ellipsis,
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
                                        SizedBox(width: 5,),
                                        Text("Close: ",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.prompt(
                                            textStyle: TextStyle(
                                                color: color3,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        Text(businessController.businesses!=null?businessController.businesses[index].closingTime:'-',
                                          overflow: TextOverflow.ellipsis,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon:  FaIcon(FontAwesomeIcons.chartPie, color: color3, size: 30,),
                                        onPressed: (){
                                          Navigator.push(context,MaterialPageRoute(builder:(context)=>BusinessReport(businessController.businesses[index].id)));
                                        },
                                      ),
                                      IconButton(
                                        icon:  FaIcon(FontAwesomeIcons.qrcode, color: color3, size: 30,),
                                        onPressed: (){
                                          push(context,MaterialPageRoute(builder:(context)=>BusinessQRCode(businessController.businesses[index])));                                              },
                                      ),
                                      IconButton(
                                        icon:  FaIcon(FontAwesomeIcons.list, color: color3,  size: 30,),
                                        onPressed: (){
                                          push(context,MaterialPageRoute(builder:(context)=>BusinessCategoryList(businessController.businesses[index].id)));                                              },
                                      ),
                                      IconButton(
                                        icon:  FaIcon(FontAwesomeIcons.comments, color: color3,  size: 30,),
                                        onPressed: (){
                                          push(context,MaterialPageRoute(builder:(context)=>IndividualFeedbacks(businessId:businessController.businesses[index].id,isAdmin: true,)));                                              },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          child: Container(
                            width: 140,
                            height: 240,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      businessController.businesses!=null&&businessController.businesses[index].image!=null?businessController.businesses[index].image:''
                                  ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left:8,
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
                        ),
                      ],
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