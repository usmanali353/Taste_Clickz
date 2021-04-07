import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:review_app/Interfaces/ISubCategoryRepository.dart';
import 'package:review_app/Models/CategoriesViewModel.dart';
import 'package:http/http.dart'as http;
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/Utils/Utils.dart';
class SubCategoryRepository extends ISubCategoryRepository{
  @override
  Future<http.Response> addSubCategories(CategoriesViewModel categoriesViewModel,BuildContext context)async{
    locator<Logger>().i(categoriesViewModel.toJson());
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var res=await http.post(Utils.baseUrl()+"Subcategories",body:CategoriesViewModel.CategoriesViewModelToJson(categoriesViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
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
  Future<List<CategoriesViewModel>> getSubCategories(int categoryId,BuildContext context) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Subcategories?categoryId=$categoryId",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        progressDialog.dismiss();
        locator<Logger>().i(CategoriesViewModel.CategoriesListFromJson(response.body));
        return CategoriesViewModel.CategoriesListFromJson(response.body);
      }else if(response.body!=null&&response.body.isNotEmpty){
        progressDialog.dismiss();
        Utils.showError(context,response.body.toString());
      }else
        progressDialog.dismiss();
      Utils.showError(context,response.statusCode.toString());
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
    var response=await http.get(Utils.baseUrl()+"Subcategories/ChangeVisibility/$id",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
    if(response.statusCode==200){
      Utils.showSuccess(context,"Visibility Changed");
    }else if(response.body!=null&&response.body.isNotEmpty){
      Utils.showError(context,response.body);
    }else
      Utils.showError(context,response.statusCode.toString());
    return null;
  }
  @override
  Future<http.Response> updateSubCategories(int id,CategoriesViewModel categoriesViewModel, BuildContext context) async{
    locator<Logger>().i(categoriesViewModel.toJson());
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var res=await http.put(Utils.baseUrl()+"Subcategories/$id",body:CategoriesViewModel.CategoriesViewModelToJson(categoriesViewModel),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
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
  Future<List<CategoriesViewModel>> getSubCategoriesforCustomer(int categoryId, BuildContext context) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Subcategories/getSubcategoriesforCustomer?categoryId=$categoryId",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      if(response.statusCode==200){
        progressDialog.dismiss();
        locator<Logger>().i(CategoriesViewModel.CategoriesListFromJson(response.body));
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