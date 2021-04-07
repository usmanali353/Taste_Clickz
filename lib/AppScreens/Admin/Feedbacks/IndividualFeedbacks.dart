import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class IndividualFeedbacks extends StatefulWidget {
  int businessId;
  bool isAdmin;

  IndividualFeedbacks({this.businessId,this.isAdmin});

  @override
  _IndividualFeedbacksState createState() => _IndividualFeedbacksState();
}

class _IndividualFeedbacksState extends State<IndividualFeedbacks> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _feedbackcontroller=Get.put(FeedbackController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Individual Feedback",
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
              if(widget.isAdmin) {
                _feedbackcontroller.getFeedBack(widget.businessId, context);
              }else{
                _feedbackcontroller.getFeedBackByEmail(context);
              }
            }else{
              Utils.showError(context,"Network not Available");
            }
          });
        },
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
          Obx((){
            return ListView.builder(itemCount:_feedbackcontroller.feedbacks.length, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 225,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: color3, width: 1)
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Card(
                                  elevation:4,
                                  color: color3,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: color3,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(child: FaIcon(FontAwesomeIcons.userTie, color: color4,)),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Card(
                                  elevation:4,
                                  color: Colors.white,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 80 ,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(_feedbackcontroller.feedbacks[index].customerName,
                                        style: GoogleFonts.prompt(
                                          textStyle: TextStyle(
                                            color: color1,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Card(
                                  elevation:4,
                                  color: color3,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: color3,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(child: FaIcon(FontAwesomeIcons.storeAlt, color: color4, size: 20,)),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Card(
                                  elevation:4,
                                  color: Colors.white,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Text("Restaurant: ",
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                  color: color3,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Text(_feedbackcontroller.feedbacks[index].businessName!=null?_feedbackcontroller.feedbacks[index].businessName.toString():"-".toString(),
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                color: color1,
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              children: [
                                Card(
                                  elevation:4,
                                  color: color3,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: color3,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(child: FaIcon(FontAwesomeIcons.at, color: color4,)),
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Card(
                                  elevation:4,
                                  color: Colors.white,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Text("Email: ",
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                  color: color3,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Text(_feedbackcontroller.feedbacks[index].email,
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                color: color1,
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Card(
                                      elevation:4,
                                      color: color3,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: color3,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(child: FaIcon(FontAwesomeIcons.solidGrinStars, color: color4,)),
                                      ),
                                    ),
                                    SizedBox(width: 3,),
                                    Card(
                                      elevation:4,
                                      color: Colors.white,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 290,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child:  Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Row(
                                            children: [
                                              Text("Ratings: ",
                                                style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                      color: color3,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Text(_feedbackcontroller.feedbacks[index].overallRating.toStringAsFixed(1),
                                                style: GoogleFonts.prompt(
                                                  textStyle: TextStyle(
                                                    color: color1,
                                                    fontSize: 15,
                                                    //fontWeight: FontWeight.w600
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
                                SizedBox(width: 5,),
                                Row(
                                  children: [
                                    Card(
                                      elevation: 4,
                                      color: color3,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: color3,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(child: FaIcon(FontAwesomeIcons.mobileAlt, color: color4,)),
                                      ),
                                    ),
                                    SizedBox(width: 3,),
                                    Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 255,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child:  Center(
                                          child:  Text(_feedbackcontroller.feedbacks[index].phone,
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                color: color1,
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Card(
                                      elevation: 4,
                                      color: color3,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: color3,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(child: FaIcon(FontAwesomeIcons.city, color: color4, size: 20,)),
                                      ),
                                    ),
                                    SizedBox(width: 3,),
                                    Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 290,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child:  Center(
                                          child:  Text(_feedbackcontroller.feedbacks[index].city!=null?_feedbackcontroller.feedbacks[index].city:"-",
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                color: color1,
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5,),
                                Row(
                                  children: [
                                    Card(
                                      elevation: 4,
                                      color: color3,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: color3,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Center(child: FaIcon(FontAwesomeIcons.globeAmericas, color: color4,)),
                                      ),
                                    ),
                                    SizedBox(width: 3,),
                                    Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 255,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child:  Center(
                                          child:  Text(_feedbackcontroller.feedbacks[index].country!=null?_feedbackcontroller.feedbacks[index].country:"-",
                                            style: GoogleFonts.prompt(
                                              textStyle: TextStyle(
                                                color: color1,
                                                fontSize: 15,
                                                //fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              );
            });
          }),
        ),
      ),
    );
  }
}
