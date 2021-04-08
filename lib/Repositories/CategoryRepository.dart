import 'dart:convert';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:review_app/Interfaces/ICategoryRepository.dart';
import 'package:review_app/Models/CategoriesViewModel.dart';
import 'package:http/http.dart'as http;
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/Utils/Utils.dart';
class CategoryRepository extends ICategoryRepository{
  @override
  Future<http.Response> addCategories(CategoriesViewModel categoriesViewModel,BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var res=await http.post(Utils.baseUrl()+"Categories",body:CategoriesViewModel.CategoriesViewModelToJson(categoriesViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      progressDialog.dismiss();
      if(res.statusCode==200||res.statusCode==201)
      {
        progressDialog.dismiss();
        Navigator.pop(context,"Refresh");
        Utils.showSuccess(context,res.body.trim());
        return res;
      }else if(res.body!=null&&res.body.isNotEmpty){
        progressDialog.dismiss();
        Utils.showError(context,res.body.trim());
        return res;
      }else {
        progressDialog.dismiss();
        Utils.showSuccess(context, res.statusCode.toString());
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
  Future<List<CategoriesViewModel>> getCategories(int businessId,BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Categories/GetCategoriesByBusiness/$businessId",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        progressDialog.dismiss();

       // locator<Logger>().i(CategoriesViewModel.CategoriesListFromJson(response.body));
        return CategoriesViewModel.CategoriesListFromJson(response.body);
      }else if(response.body!=null&&response.body.isNotEmpty){
        progressDialog.dismiss();
        Utils.showError(context,response.body.toString());
      }else {
        progressDialog.dismiss();
        Utils.showError(context, response.statusCode.toString());
      }
    }catch(e){
      progressDialog.dismiss();
      Utils.showError(context,e.toString());
    }finally{
      progressDialog.dismiss();
    }
    return null;
  }
  @override
  Future<void> changeVisibility(int id, BuildContext context)async {
   var response=await http.get(Utils.baseUrl()+"Categories/ChangeVisibility/$id",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
   if(response.statusCode==200){
     Utils.showSuccess(context,"Visibility Changed");
   }else if(response.body!=null&&response.body.isNotEmpty){
     Utils.showError(context,response.body);
   }else
     Utils.showError(context,response.statusCode.toString());
    return null;
  }
  @override
  Future<http.Response> updateCategories(int id,CategoriesViewModel categoriesViewModel, BuildContext context)async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var res=await http.put(Utils.baseUrl()+"Categories/$id",body:CategoriesViewModel.CategoriesViewModelToJson(categoriesViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      locator<Logger>().i(Utils.baseUrl()+"Categories/$id");
      locator<Logger>().i(CategoriesViewModel.CategoriesViewModelToJson(categoriesViewModel));
      locator<Logger>().i(res.body);
      progressDialog.dismiss();
      if(res.statusCode==200||res.statusCode==201||res.statusCode==204)
      {
        progressDialog.dismiss();
        Navigator.pop(context,"Refresh");
      }else if(res.body!=null&&res.body.isNotEmpty){
        progressDialog.dismiss();
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
  Future<List<CategoriesViewModel>> getCategoriesforCustomer(int businessId, BuildContext context) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Categories/GetCategoriesByBusinessforCustomer/$businessId",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        progressDialog.dismiss();
        return CategoriesViewModel.CategoriesListFromJson(response.body);
      }else if(response.body!=null&&response.body.isNotEmpty){
        progressDialog.dismiss();
        Utils.showError(context,response.body.toString());
      }else {
        progressDialog.dismiss();
        Utils.showError(context, response.statusCode.toString());
      }
    }catch(e){
      progressDialog.dismiss();
      Utils.showError(context,e.toString());
    }finally{
      progressDialog.dismiss();
    }
    return null;
  }
}