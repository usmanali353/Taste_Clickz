import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:review_app/AppScreens/Admin/Questionnaire/AddAQuestion.dart';
import 'package:review_app/AppScreens/Admin/Questionnaire/Options/OptionsList.dart';
import 'package:review_app/Controllers/QuestionsController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

import 'UpdateQuestion.dart';


class QuestionnaireList extends StatefulWidget {
  int businessId,categoryId,subCategoryId;

  QuestionnaireList({this.businessId, this.categoryId, this.subCategoryId});

  @override
  _QuestionnaireListState createState() => _QuestionnaireListState();
}

class _QuestionnaireListState extends ResumableState<QuestionnaireList> {
  final _questionController=Get.put(QuestionController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }
  @override
  void onResume() {
    if(resume.data=="Refresh"){
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    }
    super.onResume();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: color4,size:25,),
            onPressed: (){
              push(context, MaterialPageRoute(builder: (context)=> AddAQuestion(widget.businessId,widget.categoryId,widget.subCategoryId)));
            },
          ),
        ],
        title: Text("Questionnaire",
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
          Utils.check_connectivity().then((isConnected){
            if(isConnected){
              _questionController.getQuestions(widget.subCategoryId, context);
            }else{
              Utils.showError(context,"Network not Available");
            }
          });
        },
        child: Container(
          color: color4,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx((){
            return ListView.builder(itemCount:_questionController.questionList.length, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.edit,
                        color: color2,
                        caption: 'Update',
                        onTap: () {
                          push(context,MaterialPageRoute(builder:(context)=>UpdateQuestion(widget.businessId,widget.categoryId,widget.subCategoryId,_questionController.questionList[index])));

                        },
                      ),
                      IconSlideAction(
                        icon: _questionController.questionList[index].isVisible?Icons.visibility_off:Icons.visibility,
                        color: Colors.red,
                        caption: 'Visibility',
                        onTap: () {
                           _questionController.changeVisibility(_questionController.questionList[index].id, widget.subCategoryId, context);
                        },
                      ),
                    ],
                    child: Card(
                      elevation: 6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: 70,
                        decoration: BoxDecoration(
                          //color: color1,
                            borderRadius: BorderRadius.circular(10),
                            //border: Border.all(color: color3, width: 2)
                        ),
                        child: ListTile(
                          onTap: () {
                            print(_questionController.questionList[index].id);
                             Navigator.push(context,MaterialPageRoute(builder:(context)=>QuestionOptionsList(_questionController.questionList[index].id)));
                          },
                          title: Text(_questionController.questionList[index].questionText,
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color3,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          subtitle: Text(Utils.getQuestionType(_questionController.questionList[index].questionType),
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              );
            });
          })
        ),
      ),
    );
  }
}
