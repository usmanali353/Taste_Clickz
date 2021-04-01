import 'dart:convert';

import 'package:review_app/Models/feedback.dart';

class OverallReport{
  double positiveFeedbackCount,negetiveFeedbackCont;
  OverallReport({
    this.positiveFeedbackCount,
    this.negetiveFeedbackCont,
  });
 static OverallReport OverallReportFromJson(String str) => OverallReport.fromJson(json.decode(str));

 static String OverallReportToJson(OverallReport data) => json.encode(data.toJson());
  factory OverallReport.fromJson(Map<String, dynamic> json) => OverallReport(
    positiveFeedbackCount: json["positiveFeedbackCount"],
    negetiveFeedbackCont: json["negetiveFeedbackCont"],
  );

  Map<String, dynamic> toJson() => {
    "positiveFeedbackCount": positiveFeedbackCount,
    "negetiveFeedbackCont": negetiveFeedbackCont,
  };
}