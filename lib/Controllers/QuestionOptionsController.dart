import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/Interfaces/IQuestionOptionsRepository.dart';
import 'package:review_app/Models/QuestionOptions.dart';
import 'package:review_app/Utils/Locator.dart';

import '../Models/QuestionOptions.dart';

class QuestionOptionsController extends GetxController{
  TextEditingController questionOptionText,value;
  var _questionOptionsRepository= locator<IQuestionOptionsRepository>();
  var questionList =<QuestionOptions>[].obs;
  @override
  void onInit() {
    if(questionOptionText==null){
      questionOptionText=TextEditingController();
      value=TextEditingController();
    }
  }
  void AddQuestionOptions(int questionId,BuildContext context){
    _questionOptionsRepository.addQuestionOptions(QuestionOptions(
        questionOptionText:  questionOptionText.text,
        rating: double.parse(value.text),
        questionOptionId: 0,
        questionId: questionId
    ), context).then((response){
      if(response.statusCode==200||response.statusCode==201) {
        questionOptionText.text = "";
      }
    });
  }
  void UpdateQuestionOptions(QuestionOptions questionOptions,BuildContext context){
    _questionOptionsRepository.updateQuestionOptions(QuestionOptions(
      questionOptionText:  questionOptionText.text,
      rating: double.parse(value.text),
      questionId: questionOptions.questionId,
      questionOptionId: questionOptions.questionOptionId,
    ), context).then((response){
      if(response.statusCode==200||response.statusCode==204) {
        questionOptionText.text = "";
      }
    });
  }
  void getQuestionOptions(int questionId,BuildContext context){
    _questionOptionsRepository. getQuestionOptions(questionId,context).then((questionlist){
      questionList.clear();
      questionList.assignAll(questionlist);
    });
  }
  void changeVisibility(int id,BuildContext context){
    _questionOptionsRepository.changeVisibility(id, context).then((value){
      // getQuestions(subCategoryId, context);
    });
  }

  @override
  void onClose() {
    questionOptionText?.dispose();
  }
}