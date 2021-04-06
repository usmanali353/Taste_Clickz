import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:review_app/Models/OverallReport.dart';
import 'package:review_app/Models/feedback.dart';

abstract class IFeedBackRepository{
 Future<Response> AddFeedBack(feedback feedback,String businessOwnerId,String businessName,BuildContext context);
 Future<List<feedback>> getFeedBack(int categoryId,int subcategoryId,int businessId,String email,BuildContext context);
 Future<OverallReport> getOverAllReport(int businessId,double days,BuildContext context);
 Future<List<feedback>> getFeedbackforCustomer(int categoryId,int subcategoryId,int businessId,String email,BuildContext context);
 Future<Response> updateFeedBack(feedback feedback,BuildContext context);
 Future<void> changeVisibility(int id,BuildContext context);
}