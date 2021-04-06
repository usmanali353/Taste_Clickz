import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/FeedbackDetails.dart';
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
          color: color4,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Obx((){
            return ListView.builder(itemCount:_feedbackcontroller.feedbacks.length, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    if(_feedbackcontroller.feedbacks[index].customerFeedBacks.length>0){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>FeedbackDetails(_feedbackcontroller.feedbacks[index].customerFeedBacks,_feedbackcontroller.feedbacks[index])));
                    }else{
                      Utils.showError(context,"No Details Available");
                    }
                  },
                  child: Card(
                    elevation: 6,
                    color: color4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      decoration: BoxDecoration(
                        //color: color1,
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: color3, width: 2)
                      ),
                      child: ListTile(
                        title: Text(_feedbackcontroller.feedbacks[index].customerName,
                          style: GoogleFonts.prompt(
                            textStyle: TextStyle(
                                color: color1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
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
                                Text(_feedbackcontroller.feedbacks[index].customerName,
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Overall Rating: ",
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
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("City: ",
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(_feedbackcontroller.feedbacks[index].city!=null?_feedbackcontroller.feedbacks[index].city:"-",
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Country: ",
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(_feedbackcontroller.feedbacks[index].country!=null?_feedbackcontroller.feedbacks[index].country:"-",
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
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
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Phone: ",
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color3,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(_feedbackcontroller.feedbacks[index].phone,
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                        color: color1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: FaIcon(
                          FontAwesomeIcons.comments,
                          color: color3,
                          size: 35,
                        ),
                      ),
                    ),
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
