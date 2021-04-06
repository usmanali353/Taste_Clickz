import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/CommentWithPicture.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/Controllers/QuestionsController.dart';
import 'package:review_app/Models/CustomerFeedBack.dart';
import 'package:review_app/Models/QuestionOptions.dart';
import 'package:review_app/Models/SelectedOptions.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class AddRatings extends StatefulWidget {
  var businessId,categoryId,subcategoryId,businessOwnerId,businessName;

  AddRatings({this.businessId,this.categoryId,this.subcategoryId,this.businessOwnerId,this.businessName});

  @override
  _AddRatingsState createState() => _AddRatingsState();
}

class _AddRatingsState extends State<AddRatings> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  var groupValue,groupValue2;
  final _questionController =Get.put(QuestionController());
  final _feedbackController=Get.put(FeedbackController());
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _feedbackController.customerFeedback.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Rating",
          style: GoogleFonts.prompt(
            textStyle: TextStyle(
                color: color4,
                fontSize: 22, ),

                fontWeight: FontWeight.bold
            ),
          ),
        iconTheme: IconThemeData(
            color: color4
        ),
        centerTitle: true,
        backgroundColor: color3,
        actions: [
          IconButton(
            icon:Icon(Icons.add, color: color4, size: 30,),
            onPressed: (){
             Navigator.push(context,MaterialPageRoute(builder: (context)=>CommentWithPicture(businessId: widget.businessId,subcategoryId: widget.subcategoryId,categoryId: widget.categoryId,businessOwnerId: widget.businessOwnerId,businessName: widget.businessName,)));
            },
          )
        ],
      ),

      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: ()async{
          return Utils.check_connectivity().then((isConnected){
            if(isConnected){
              _questionController.getQuestionsforCustomer(widget.subcategoryId, context);
            }
          });
        },
        child: Container(
          color: color4,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:Obx((){

            return ListView.builder(itemCount: _questionController.questionList.length, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 6,
                  color: color4,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //height: 190,
                    decoration: BoxDecoration(
                      //color: color4,
                      borderRadius: BorderRadius.circular(8),
                      //border: Border.all(color: color1, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_questionController.questionList[index].questionText,
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color3,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        _questionController.questionList[index].questionType==1?Center(
                          child: RatingBar.builder(
                            initialRating: 0,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.red,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.sentiment_dissatisfied,
                                    color: Colors.redAccent,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.sentiment_neutral,
                                    color: Colors.amber,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.sentiment_satisfied,
                                    color: Colors.lightGreen,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.green,
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {
                                _feedbackController.customerFeedback.insert(index,
                                    CustomerFeedBack(
                                        businessId: widget.businessId,
                                        categoryId: _questionController
                                            .questionList[index].categoryId,
                                        subCategoryId: _questionController
                                            .questionList[index].subCategoryId,
                                        questionId: _questionController
                                            .questionList[index].id,
                                        rating: rating,
                                      questions: _questionController.questionList[index],

                                      selectedOptions: [],
                                    ));
                            },
                          ),
                        ):_questionController.questionList[index].questionType==2?Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CustomRadioButton(
                              enableShape: true,
                              elevation: 0,
                              //defaultSelected: "Sunday",

                              enableButtonWrap: true,
                              width: 120,
                              autoWidth: true,
                              unSelectedColor: Theme.of(context).canvasColor,
                              buttonLables: [
                                "Yes",
                                "No"
                              ],
                              selectedBorderColor: Colors.white,
                              unSelectedBorderColor: color3,
                              buttonValues: [
                                5.0,
                                2.0
                              ],
                              radioButtonValue: (value) {
                                List<SelectedOptions> options=[];
                                _feedbackController.customerFeedback.insert(index,
                                    CustomerFeedBack(
                                      businessId: widget.businessId,
                                      categoryId: _questionController
                                          .questionList[index].categoryId,
                                      subCategoryId: _questionController
                                          .questionList[index].subCategoryId,
                                      questionId: _questionController
                                          .questionList[index].id,
                                        questions: _questionController.questionList[index],
                                      rating:  value,
                                      selectedOptions: []
                                    ));
                              },
                              selectedColor: color3,
                            )
                          ],
                        ):_questionController.questionList[index].questionType==3?

                        Container(
                          child:CustomRadioButton(
                                    enableShape: true,
                                    elevation: 0,
                                    //defaultSelected: "Sunday",

                                    enableButtonWrap: true,
                                    width: 120,
                                    autoWidth: true,
                                    unSelectedColor: Theme.of(context).canvasColor,
                                    buttonLables: [
                                      for(var options in _questionController.questionList[index].questionOptions)
                                                   options.questionOptionText
                                      ],
                                     selectedBorderColor: Colors.white,
                                     unSelectedBorderColor: color3,
                                    buttonValues: [
                                      for(var options in _questionController.questionList[index].questionOptions)
                                        options.questionOptionText
                                    ],
                                    radioButtonValue: (value) {

                                      List<SelectedOptions> options=[];
                                      Iterable<QuestionOptions> option= _questionController.questionList[index].questionOptions.where((element) => element.questionOptionText==value);
                                      options.add(SelectedOptions(questionOptionsId: option.elementAt(0).questionOptionId));
                                                      _feedbackController.customerFeedback.insert(index,
                                                          CustomerFeedBack(
                                                            businessId: widget.businessId,
                                                            categoryId: _questionController
                                                                .questionList[index].categoryId,
                                                            subCategoryId: _questionController
                                                                .questionList[index].subCategoryId,
                                                            questionId: _questionController
                                                                .questionList[index].id,
                                                            questions: _questionController.questionList[index],
                                                            rating:  option.elementAt(0).rating,
                                                            selectedOptions: options,
                                                          ));
                                      print(jsonEncode(_feedbackController.customerFeedback));
                                    },
                                    selectedColor: color3,
                                  ),
                        ):Container()
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
