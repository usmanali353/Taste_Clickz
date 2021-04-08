import 'dart:convert';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:review_app/Interfaces/IBusinessRepository.dart';
import 'package:review_app/Models/BusinessByCustomerViewModel.dart';
import 'package:review_app/Models/BusinessViewModel.dart';
import 'package:http/http.dart'as http;
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/Utils/Utils.dart';
class BusinessRepository extends IBusinessRepository{
  @override
  Future<http.Response> addBusiness(BusinessViewModel businessViewModel, BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var res=await http.post(Utils.baseUrl()+"Business/CreateBusiness",body:BusinessViewModel.BusinessViewModelToJson(businessViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      progressDialog.dismiss();
      locator<Logger>().i(BusinessViewModel.BusinessViewModelToJson(businessViewModel));
      if(res.statusCode==200)
      {
        progressDialog.dismiss();
        Navigator.pop(context,"Refresh");
        Utils.showSuccess(context,"Business Added Sucessfully");
        return res;
      }else if(res.body!=null&&res.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(res.body.trim());
        Utils.showError(context,res.body.trim());
        return res;
      }else {
        progressDialog.dismiss();
        Utils.showError(context,"Not Added");
        return res;
      }
    }catch(e){
      progressDialog.dismiss();
      Utils.showError(context, e.toString());
    }finally{
      progressDialog.dismiss();
    }
  }

  @override
  Future<List<BusinessViewModel>> getBusinessByOwner(BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Business/GetBusinessByOwner",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        locator<Logger>().i(BusinessViewModel.BusinessListFromJson(response.body));
        return BusinessViewModel.BusinessListFromJson(response.body);
      }else if(response.body!=null&&response.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(response.body);
       // Utils.showError(context,response.body);
      }else
        progressDialog.dismiss();
        Utils.showError(context,response.statusCode.toString());
    }catch(e){
      locator<Logger>().i(e);
     // Utils.showError(context,e.toString());
      progressDialog.dismiss();
    }finally{
      progressDialog.dismiss();
    }
    return null;
  }
  @override
  Future<http.Response> updateBusiness(BusinessViewModel businessViewModel, BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var res=await http.put(Utils.baseUrl()+"Business/${businessViewModel.id}",body:BusinessViewModel.BusinessViewModelToJson(businessViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      progressDialog.dismiss();
      locator<Logger>().i(BusinessViewModel.BusinessViewModelToJson(businessViewModel));
      if(res.statusCode==200)
      {
        progressDialog.dismiss();
        Navigator.pop(context,"Refresh");
        Utils.showSuccess(context,"Business Updated Sucessfully");
      }else if(res.body!=null&&res.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(res.body.trim());
        Utils.showError(context,res.body.trim());
      }else {
        progressDialog.dismiss();
        Utils.showError(context, res.statusCode.toString());
      }
    }catch(e){
      progressDialog.dismiss();
      Utils.showError(context, e.toString());
    }finally{
      progressDialog.dismiss();
    }
  }

  @override
  Future<void> changeVisibility(int id, BuildContext context)async {
    var response=await http.get(Utils.baseUrl()+"Business/ChangeVisibility/$id",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
    if(response.statusCode==200){
      Utils.showSuccess(context,"Visibility Changed");
    }else if(response.body!=null&&response.body.isNotEmpty){
      Utils.showError(context,response.body);
    }else
      Utils.showError(context,response.statusCode.toString());
    return null;
  }

  @override
  Future<List<BusinessViewModel>> getBusinessForCustomer(BusinessByCustomerViewModel businessByCustomerViewModel, BuildContext context)async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.post(Utils.baseUrl()+"Business/getBusinessForCustomer",body:BusinessByCustomerViewModel.BusinessByCustomerViewModelToJson(businessByCustomerViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        locator<Logger>().i(BusinessViewModel.BusinessListFromJson(response.body));
        return BusinessViewModel.BusinessListFromJson(response.body);
      }else if(response.body!=null&&response.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(response.body);
        // Utils.showError(context,response.body);
      }else {
        progressDialog.dismiss();
        Utils.showError(context, response.statusCode.toString());
      }
    }catch(e){
      locator<Logger>().i(e);
      // Utils.showError(context,e.toString());
      progressDialog.dismiss();
    }finally{
      progressDialog.dismiss();
    }
    return null;
  }

  @override
  Future<BusinessViewModel> getBusinessById(int businessId, BuildContext context) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Business/$businessId",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        locator<Logger>().i(BusinessViewModel.BusinessListFromJson(response.body));
        return BusinessViewModel.BusinessFromJson(response.body);
      }else if(response.body!=null&&response.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(response.body);
        // Utils.showError(context,response.body);
      }else
        progressDialog.dismiss();
      Utils.showError(context,response.statusCode.toString());
    }catch(e){
      locator<Logger>().i(e);
      // Utils.showError(context,e.toString());
      progressDialog.dismiss();
    }finally{
      progressDialog.dismiss();
    }
    return null;
  }
}