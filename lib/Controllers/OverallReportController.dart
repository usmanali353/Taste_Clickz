import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/Interfaces/IFeedbackRepository.dart';
import 'package:review_app/Utils/Locator.dart';

class OverallReportController extends GetxController{
final _feedbackRepository =locator<IFeedBackRepository>();
var dataMap=Map<String, double>().obs;

  void getOverallReport(int businessId,double days,BuildContext context){
    _feedbackRepository.getOverAllReport(businessId, days, context).then((value){
      dataMap.clear();
      dataMap.putIfAbsent("Positive Rating", () => double.parse(value.positiveFeedbackCount.toString()));
      dataMap.putIfAbsent("Negetive Rating", () => double.parse(value.negetiveFeedbackCont.toString()));
    });
  }
}