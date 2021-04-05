import 'package:expandable_card/expandable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/Admin/Business/NewDetailScreen.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/FeedbackDetails.dart';
import 'package:review_app/AppScreens/Customer/ReviewCategory/SelectReviewCategory.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/Models/BusinessViewModel.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

import '../../../Models/feedback.dart';

class DetailPage extends StatefulWidget {
  BusinessViewModel business;

  DetailPage({this.business});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final feedbackController =Get.put(FeedbackController());
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: ExpandableCardPage(
        page: BusinessProfileScreen(business: widget.business,),
        expandableCard: ExpandableCard(
          backgroundColor: color1,
          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
          maxHeight: MediaQuery.of(context).size.height - 100,
          minHeight: 105,
          hasRoundedCorners: true,
          hasShadow: true,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.comments, color: color3, size: 35, ),
                        SizedBox(width: 7,),
                        Text("Reviews",
                          style: GoogleFonts.prompt(
                            textStyle: TextStyle(
                                color: color4,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 130,),
                        IconButton(icon: FaIcon(FontAwesomeIcons.commentMedical, color: color3, size: 35,),
                            onPressed: (){
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>SelectReviewCategoryList(widget.business.id)));
                            })
                      ],
                    ),

                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: ()async{
                return Utils.check_connectivity().then((isConnected){
                  if(isConnected){
                    feedbackController.getFeedBackforCustomer(widget.business.id, context);
                  }else{
                    Utils.showError(context,"Network not Available");
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: color1, width: 2)
                ),
                width: MediaQuery.of(context).size.width,
                height: 500,
                child:Obx((){
                   return ListView.builder(itemCount:feedbackController.feedbacks.length, itemBuilder: (context, index){
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: InkWell(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> FeedbackDetails(feedbackController.feedbacks[index].customerFeedBacks,feedbackController.feedbacks[index])));

                         },
                         child: Container(
                           width: MediaQuery.of(context).size.width,
                           //height: 100,
                           decoration: BoxDecoration(
                             //color: color1,
                               borderRadius: BorderRadius.circular(10),
                               border: Border.all(color: color3, width: 2)
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(feedbackController.feedbacks[index].customerName,
                                         style: GoogleFonts.prompt(
                                           textStyle: TextStyle(
                                               color: color4,
                                               fontSize: 17,
                                               fontWeight: FontWeight.bold
                                           ),
                                         ),
                                       ),
                                       Row(
                                         children: [
                                           FaIcon(
                                             FontAwesomeIcons.solidStar,
                                             color: Colors.amber,
                                             size: 20,
                                           ),
                                           SizedBox(width: 2,),
                                           Text(feedbackController.feedbacks[index].overallRating.toStringAsFixed(1),
                                             style: GoogleFonts.prompt(
                                               textStyle: TextStyle(
                                                   color: color4,
                                                   fontSize: 15,
                                                   fontWeight: FontWeight.bold
                                               ),
                                             ),
                                           ),
                                         ],
                                       )
                                     ]
                                 ),
                               ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               width: MediaQuery.of(context).size.width,

                               child: Text(
                                 //"If extended to other regions where shark attacks are relatively common, the potential for avoiding injury and death is far higher, they reported in the journal Royal Society Open Science.",
                                 feedbackController.feedbacks[index].comment,
                                 maxLines: 3,
                                         style: GoogleFonts.prompt(
                                           textStyle: TextStyle(
                                               color: color3,
                                               fontSize: 12,
                                               fontWeight: FontWeight.bold
                                           ),
                                         ),
                                       ),
                             ),
                           ),
                             ],
                           )
                           // ListTile(
                           //   onTap: (){
                           //     Navigator.push(context,MaterialPageRoute(builder:(context)=>FeedbackDetails(feedbackController.feedbacks[index].customerFeedBacks,feedbackController.feedbacks[index])));
                           //   },
                           //   title: Text(feedbackController.feedbacks[index].customerName,
                           //     style: GoogleFonts.prompt(
                           //       textStyle: TextStyle(
                           //           color: color4,
                           //           fontSize: 17,
                           //           fontWeight: FontWeight.bold
                           //       ),
                           //     ),
                           //   ),
                           //   subtitle: Row(
                           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           //     children: [
                           //       Text(feedbackController.feedbacks[index].comment,
                           //         maxLines: 3,
                           //         style: GoogleFonts.prompt(
                           //           textStyle: TextStyle(
                           //               color: color3,
                           //               fontSize: 15,
                           //               fontWeight: FontWeight.bold
                           //           ),
                           //         ),
                           //       ),
                           //       Row(
                           //         children: [
                           //           FaIcon(
                           //             FontAwesomeIcons.solidStar,
                           //             color: Colors.amber,
                           //             size: 20,
                           //           ),
                           //           SizedBox(width: 2,),
                           //           Text(feedbackController.feedbacks[index].overallRating.toStringAsFixed(1),
                           //             style: GoogleFonts.prompt(
                           //               textStyle: TextStyle(
                           //                   color: color4,
                           //                   fontSize: 15,
                           //                   fontWeight: FontWeight.bold
                           //               ),
                           //             ),
                           //           ),
                           //         ],
                           //       )
                           //     ],
                           //   ),
                           //
                           //   leading: FaIcon(
                           //     FontAwesomeIcons.comments,
                           //     color: color3,
                           //     size: 35,
                           //   ),
                           // ),
                         ),
                       ),
                     );
                   });
                })
              ),
            )
          ],
        ),
      ),
    );
  }
}
