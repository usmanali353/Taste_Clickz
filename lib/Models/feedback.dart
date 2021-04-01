import 'dart:convert';

import 'package:review_app/Models/CustomerFeedBack.dart';

class feedback{
  String customerName,phone,email,comment,image,city,country,businessName;
  int businessId,categoryId,subCategoryId,id;
  List<CustomerFeedBack> customerFeedBacks;
  double overallRating;
  feedback({
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
    this.overallRating,
    this.id,
    this.businessName
  });
  static feedback FeedbackFromJson(String str) => feedback.fromJson(json.decode(str));
  static List<feedback> FeedbackListFromJson(String str) => List<feedback>.from(json.decode(str).map((x) => feedback.fromJson(x)));
  static String FeedbackToJson(feedback data) => json.encode(data.toJson());
  static String FeedbackAddToJson(feedback data) => json.encode(data.addjson());
  static String FeedbackUpdateToJson(feedback data) => json.encode(data.toMap());
  factory feedback.fromJson(Map<String, dynamic> json) => feedback(
    customerName: json["customerName"],
    phone: json["phone"],
    email :json["email"],
    city: json["city"],
    country: json["country"],
    comment:json["comment"],
    image: json["image"],
      businessName: json['businessName'],
      businessId:json["businessId"],
      categoryId:json["categoryId"],
     subCategoryId: json["subCategoryId"],
      overallRating: json["overallRating"],
      customerFeedBacks: json['customerFeedBacks']!=null?List<CustomerFeedBack>.from(json["customerFeedBacks"].map((x) => CustomerFeedBack.fromJson(x))):json['customerFeedBacks']
  );

  @override
  String toString() {
    return toJson().toString();
  }

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
  Map<String, dynamic> addjson() => {
    "customerName": customerName,
    "phone":phone,
    "email":email,
    "image":image,
    "comment":comment,
    "businessId":businessId,
    "categoryId":categoryId,
    "subCategoryId":subCategoryId,
    "customerFeedBacks":List<dynamic>.from(customerFeedBacks.map((x) => x.toMap()))
  };
  Map<String, dynamic> toMap() => {
    "id":id,
    "customerName": customerName,
    "phone":phone,
    "email":email,
    "image":image,
    "comment":comment,
    "businessId":businessId,
    "categoryId":categoryId,
    "subCategoryId":subCategoryId,
    "customerFeedBacks":List<dynamic>.from(customerFeedBacks.map((x) => x.toMap()))
  };
}