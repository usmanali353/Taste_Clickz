import 'dart:convert';

import 'package:review_app/Models/CustomerFeedBack.dart';

class Offlinefeedback{
  String customerName,phone,email,comment,image,city,country;
  int businessId,categoryId,subCategoryId;
  List<CustomerFeedBack> customerFeedBacks;
  double overallRating;
  Offlinefeedback({
    this.customerName,
    this.phone,
    this.email,
    this.city,
    this.country,
    this.comment,
    this.image,
    this.businessId,
    this.categoryId,
    this.subCategoryId,
    this.customerFeedBacks,
    this.overallRating
  });
  static Offlinefeedback OfflinefeedbackFromJson(String str) => Offlinefeedback.fromJson(json.decode(str));
  static List<Offlinefeedback> OfflinefeedbackListFromJson(String str) => List<Offlinefeedback>.from(json.decode(str).map((x) => Offlinefeedback.fromJson(x)));
  static String OfflinefeedbackToJson(Offlinefeedback data) => json.encode(data.toJson());
  factory Offlinefeedback.fromJson(Map<String, dynamic> json) => Offlinefeedback(
      customerName: json["customerName"],
      phone: json["phone"],
      email :json["email"],
      city: json["city"],
      country: json["country"],
      comment:json["comment"],
      image: json["image"],
      businessId:json["businessId"],
      categoryId:json["categoryId"],
      subCategoryId: json["subCategoryId"],
      overallRating: json["overallRating"],
      customerFeedBacks: json['customerFeedBacks']!=null?List<CustomerFeedBack>.from(json["customerFeedBacks"].map((x) => CustomerFeedBack.fromJson(x))):json['customerFeedBacks']
  );

  Map<String, dynamic> toJson() => {
    "customerName": customerName,
    "phone":phone,
    "email":email,
    "image":image,
    "comment":comment,
    "businessId":businessId,
    "categoryId":categoryId,
    "subCategoryId":subCategoryId,
    "customerFeedBacks":List<dynamic>.from(customerFeedBacks.map((x) => x.toJson()))
  };

}