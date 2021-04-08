import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:review_app/Models/BusinessByCustomerViewModel.dart';
import 'package:review_app/Models/BusinessViewModel.dart';

abstract class IBusinessRepository{
 Future<Response> addBusiness(BusinessViewModel businessViewModel,BuildContext context);
 Future<List<BusinessViewModel>> getBusinessByOwner(BuildContext context);
 Future<BusinessViewModel> getBusinessById(int businessId,BuildContext context);
 Future<List<BusinessViewModel>> getBusinessForCustomer(BusinessByCustomerViewModel businessByCustomerViewModel,BuildContext context);
 Future<Response> updateBusiness(BusinessViewModel businessViewModel,BuildContext context);
 Future<void> changeVisibility(int id,BuildContext context);
}