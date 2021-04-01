import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/Models/CustomerFeedBack.dart';
import 'package:review_app/components/colorConstants.dart';



class OfflineFeedbackDetail extends StatefulWidget {
  List customerFeedbacks;

  OfflineFeedbackDetail(this.customerFeedbacks);

  @override
  _OfflineFeedbackDetailState createState() => _OfflineFeedbackDetailState();
}

class _OfflineFeedbackDetailState extends State<OfflineFeedbackDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Details",
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
        child: ListView.builder(itemCount:widget.customerFeedbacks.length, itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 6,
              color: color4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                //height: 70,
                decoration: BoxDecoration(
                  //color: color1,
                  borderRadius: BorderRadius.circular(10),
                  //border: Border.all(color: color1, width: 2)
                ),
                child: ListTile(
                  title: Text(widget.customerFeedbacks[index]['questions']['questionText'],
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color3,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  subtitle: Text((){
                    print(widget.customerFeedbacks);
                    if(widget.customerFeedbacks[index]["questions"]['questionType']==1){
                      return widget.customerFeedbacks[index]['rating'].toString()+" Stars Rating";
                    }else if(widget.customerFeedbacks[index]['questions']['questionType']==2){
                      if(widget.customerFeedbacks[index]['rating']==5.0){
                        return "Yes";
                      }else
                        return "No";
                    }else if(widget.customerFeedbacks[index]['questions']['questionType']==3&&widget.customerFeedbacks[index]['selectedQuestionOption'].length>0){
                      List<String> selectedOptions=[];
                       if( widget.customerFeedbacks[index]['questions']['questionOptions'].length>0)
                        for (int i = 0; i < widget.customerFeedbacks[index]['questions']['questionOptions'].length; i++) {
                         if(widget.customerFeedbacks[index]['selectedQuestionOption'][0]['questionOptionsId'] == widget.customerFeedbacks[index]['questions']['questionOptions'][i]['questionOptionId'])
                           return  widget.customerFeedbacks[index]['questions']['questionOptions'][i]['questionOptionText'];
                          // selectedOptions.add(widget.customerFeedbacks[index]['questions'][i]['questionOptions']['questionOptionText']);
                      }
                      return "No Options Selected";//selectedOptions.toString().replaceAll("[","").replaceAll("]", "");
                    }else
                      return widget.customerFeedbacks[index]['rating'].toString();
                  }(),
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color1,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.comment,
                    color: color3,
                    size: 35,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
