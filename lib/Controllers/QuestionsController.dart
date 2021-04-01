import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/Interfaces/IQuestionRepository.dart';
import 'package:review_app/Models/QuestionOptions.dart';
import 'package:review_app/Models/Questions.dart';
import 'package:review_app/Utils/Locator.dart';

class QuestionController extends GetxController{
  TextEditingController questionText;
 var _questionRepository= locator<IQuestionRepository>();
 var optionsList =<QuestionOptions>[].obs;
  var questionList =<Questions>[].obs;
  List reviewTypeList=["Star Rating", "Yes/No", "Radio Button"];
  var questionTypeId=1.obs;
  @override
  void onInit() {
   if(questionText==null){
     questionText=TextEditingController();
   }
  }
  void AddQuestions(int businessId,int categoryId,int subcategoryId,BuildContext context){
      _questionRepository.addQuestions(Questions(
        id: 0,
        businessId: businessId,
        categoryId: categoryId,
        questionText: questionText.text,
        questionType: questionTypeId.value,
        subCategoryId: subcategoryId,
        questionOptions: optionsList
      ), context).then((response){
        if(response.statusCode==200||response.statusCode==201) {
          questionText.text = "";
        }
      });
   }
  void UpdateQuestions(int businessId,int categoryId,int subcategoryId,int questionId,BuildContext context){
    _questionRepository.updateQuestions(Questions(
        id: questionId,
        businessId: businessId,
        categoryId: categoryId,
        questionText: questionText.text,
        questionType: questionTypeId.value,
        subCategoryId: subcategoryId,
        questionOptions: optionsList
    ), context).then((response){
      if(response.statusCode==200||response.statusCode==204) {
        questionText.text = "";
      }
    });
  }
  void getQuestions(int subCategoryId,BuildContext context){
    _questionRepository.getQuestions(0,0,subCategoryId,context).then((questionlist){
      questionList.clear();
      questionList.assignAll(questionlist);
    });
   }
  void changeVisibility(int id,int subCategoryId,BuildContext context){
    _questionRepository.changeVisibility(id, context).then((value){
      getQuestions(subCategoryId, context);
    });
  }
  void getQuestionsforCustomer(int subCategoryId,BuildContext context){
    _questionRepository.getQuestionsforCustomer(0,0,subCategoryId,context).then((questionlist){
      questionList.clear();
      questionList.assignAll(questionlist);
    });
  }

  @override
  void onClose() {
     questionText?.dispose();
  }
}