import 'dart:convert';

import 'package:review_app/Utils/Utils.dart';

class BusinessByCustomerViewModel{
  double userLatitude,userLongitude;
  BusinessByCustomerViewModel({this.userLatitude, this.userLongitude});
  static BusinessByCustomerViewModel BusinessByCustomerViewModelFromJson(String str) => BusinessByCustomerViewModel.fromJson(json.decode(str));
  static String BusinessByCustomerViewModelToJson(BusinessByCustomerViewModel data) => json.encode(data.toJson(),toEncodable: Utils.myEncode);
  factory BusinessByCustomerViewModel.fromJson(Map<String, dynamic> json) => BusinessByCustomerViewModel(
    userLatitude: json["userLatitude"],
    userLongitude: json["userLongitude"],
  );

  Map<String, dynamic> toJson() => {
    "userLatitude": userLatitude,
    "userLongitude": userLongitude,
  };
}