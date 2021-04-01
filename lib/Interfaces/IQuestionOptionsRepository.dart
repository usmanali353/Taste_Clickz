import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:review_app/Models/QuestionOptions.dart';

abstract class IQuestionOptionsRepository{
  Future<Response> addQuestionOptions(QuestionOptions questions,BuildContext context);
  Future<Response> updateQuestionOptions(QuestionOptions questions,BuildContext context);
  Future<List<QuestionOptions>> getQuestionOptions(int questionId,BuildContext context);
  Future<void> changeVisibility(int id,BuildContext context);
}