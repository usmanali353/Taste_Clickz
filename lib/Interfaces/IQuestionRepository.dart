import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:review_app/Models/Questions.dart';

abstract class IQuestionRepository{
  Future<Response> addQuestions(Questions questions,BuildContext context);
  Future<List<Questions>> getQuestions(int businessId,int categoryId,int subcategoryId,BuildContext context);
  Future<List<Questions>> getQuestionsforCustomer(int businessId,int categoryId,int subcategoryId,BuildContext context);
  Future<void> changeVisibility(int id,BuildContext context);
  Future<Response> updateQuestions(Questions questions,BuildContext context);
}