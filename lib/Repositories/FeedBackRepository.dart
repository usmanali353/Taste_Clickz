import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:review_app/AppScreens/Customer/BottomNavBar/BottomNavBar.dart';
import 'package:review_app/AppScreens/Customer/Home/SeeAllBusinesses.dart';
import 'package:review_app/Interfaces/IFeedbackRepository.dart';
import 'package:review_app/Models/OverallReport.dart';
import 'package:review_app/Models/feedback.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:http/http.dart'as http;
import 'package:review_app/Utils/Utils.dart';


class FeedBackRepository extends IFeedBackRepository{
  @override
  Future<http.Response> AddFeedBack(feedback f,String businessOwnerId,String businessName ,BuildContext context) async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      locator<Logger>().i("nmbvbnv"+f.toString());
      locator<Logger>().i(f.customerFeedBacks.toString());
      print(feedback.FeedbackAddToJson(f));
      progressDialog.show();
      var res=await http.post(Utils.baseUrl()+"Feedback?businessOwnerId=$businessOwnerId&businessName=$businessName",body:feedback.FeedbackAddToJson(f),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      progressDialog.dismiss();
      locator<Logger>().i(res.statusCode);
      if(res.statusCode==200||res.statusCode==201)
      {
        progressDialog.dismiss();
        Utils.showSuccess(context,"Feedback Added");
        if(locator<GetStorage>().read("token")!=null) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ClientBottomNavBar()), (Route<dynamic> route) => false);
        }else{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ClientSeeAllBusinesses()), (Route<dynamic> route) => false);
        }
        return res;
      }else if(res.body!=null&&res.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(res.body.trim());
        //Utils.showSuccess(context,res.body.trim());
       // Utils.showError(context,res.body.trim());
        return res;
      }else {
        progressDialog.dismiss();
        Utils.showError(context, res.statusCode.toString());
        return res;
      }
    }catch(e){
      progressDialog.dismiss();
      locator<Logger>().e(e.toString());
      //Utils.showError(context, e.toString());
    }finally{
      progressDialog.dismiss();
    }
  }

  @override
  Future<List<feedback>> getFeedBack(int categoryId, int subcategoryId, int businessId,String email, BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Feedback?BusinessId=$businessId&CategoryId=$categoryId&SubCategoryId=$subcategoryId&email=$email",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      locator<Logger>().i(response.body);
      if(response.statusCode==200){
        progressDialog.dismiss();
        return feedback.FeedbackListFromJson(response.body);
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
    var response=await http.get(Utils.baseUrl()+"Feedback/ChangeVisibility/$id",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
    if(response.statusCode==200){
      Utils.showSuccess(context,"Visibility Changed");
    }else if(response.body!=null&&response.body.isNotEmpty){
      Utils.showError(context,response.body);
    }else
      Utils.showError(context,response.statusCode.toString());
    return null;
  }

  @override
  Future<http.Response> updateFeedBack(feedback f, BuildContext context)async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      locator<Logger>().i(f);
      progressDialog.show();
      var res=await http.put(Utils.baseUrl()+"Feedback/${f.id}",body:feedback.FeedbackUpdateToJson(f),headers: {"Content-Type":"application/json","Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      progressDialog.dismiss();
      locator<Logger>().i(res.statusCode);
      if(res.statusCode==200||res.statusCode==204)
      {
        progressDialog.dismiss();
        Utils.showSuccess(context,"Feedback Updated");
        if(locator<GetStorage>().read("token")!=null) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ClientBottomNavBar()), (Route<dynamic> route) => false);
        }else{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ClientSeeAllBusinesses()), (Route<dynamic> route) => false);
        }
      }else if(res.body!=null&&res.body.isNotEmpty){
        progressDialog.dismiss();
        locator<Logger>().i(res.body.trim());
        Utils.showSuccess(context,res.body.trim());
        // Utils.showError(context,res.body.trim());
      }else {
        progressDialog.dismiss();
        Utils.showError(context, res.statusCode.toString());
      }
    }catch(e){
      progressDialog.dismiss();
      locator<Logger>().e(e);
      //Utils.showError(context, e.toString());
    }finally{
      progressDialog.dismiss();
    }
  }

  @override
  Future<List<feedback>> getFeedbackforCustomer(int categoryId, int subcategoryId, int businessId, String email, BuildContext context)async {
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
    try{
      progressDialog.show();
      var response= await http.get(Utils.baseUrl()+"Feedback/getfeedbacksforCustomers?BusinessId=$businessId&CategoryId=$categoryId&SubCategoryId=$subcategoryId&email=$email",headers: {"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
      locator<Logger>().i(response.body);
      if(response.statusCode==200){
        progressDialog.dismiss();
        return feedback.FeedbackListFromJson(response.body);
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
  Future<OverallReport> getOverAllReport(int businessId, double days,BuildContext context) async{
    ArsProgressDialog progressDialog = ArsProgressDialog(
        context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));
      try {
        progressDialog.show();
        var response = await http.get(Utils.baseUrl() + "Feedback/GetOverallReportOfRating?businessId=$businessId&days=$days",headers:{"Authorization":"Bearer ${locator<GetStorage>().read("token")}"});
        locator<Logger>().i(response.body);
        if(response.statusCode==200){
          progressDialog.dismiss();
          return OverallReport.OverallReportFromJson(response.body);
        }else{
          Utils.showError(context,"Unable to Fetch Reports");
          progressDialog.dismiss();
        }
      }catch(e){
        progressDialog.dismiss();
        locator<Logger>().i(e);
      }finally {
        progressDialog.dismiss();
      }
     return null;
  }
}