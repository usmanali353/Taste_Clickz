import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Interfaces/IFeedbackRepository.dart';
import 'package:review_app/Models/CustomerFeedBack.dart';
import 'package:review_app/Models/feedback.dart';
import 'package:review_app/Models/offlineFeedBack.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/dbhelper.dart';

import '../AppScreens/Customer/Home/OfflineFeedback.dart';

class FeedbackController extends GetxController{
TextEditingController comment,phone,email,name,city,country;
String image;
var _feedbackRepository=locator<IFeedBackRepository>();
var feedbacks=<feedback>[].obs;
List<CustomerFeedBack> customerFeedback=<CustomerFeedBack>[];
final _accountController=Get.find<AccountController>();
  @override
  void onInit() {
    if(comment==null){
      comment=TextEditingController();
    }
    if(phone==null){
      phone=TextEditingController();
    }
    if(email==null){
      email=TextEditingController();
    }
    if(name==null){
      name=TextEditingController();
    }
    if(city==null){
      city=TextEditingController();
    }
    if(country==null){
      country=TextEditingController();
    }
    //Assigning values for Already Logged in User
    print(_accountController.getLoggedInUserData()!=null);

    customerFeedback.clear();
  }
 void addFeedback(BuildContext context,int businessId,int categoryId,int subCategoryId,String businessOwnerId,String businessName){
    var overallRating=0.0;
    final ids = customerFeedback.map((e) => e.questionId).toSet();
    customerFeedback.retainWhere((x) => ids.remove(x.questionId));
     if(locator<GetStorage>().read("token")==null){
       for(CustomerFeedBack cus in customerFeedback){
         overallRating+=cus.rating/customerFeedback.length;
       }
       print(customerFeedback);
       new dbhelper().addFeedBacks(feedback(
           subCategoryId: subCategoryId,
           categoryId: categoryId,
           phone:phone.text,
           businessId: businessId,
           email: email.text,
           customerName: name.text,
           businessName: businessName,
           comment: comment.text,
           city: city.text,
           country: country.text,
           image: image,
           overallRating: overallRating,
           customerFeedBacks: customerFeedback));
     }
    _feedbackRepository.AddFeedBack(feedback(
      subCategoryId: subCategoryId,
      categoryId: categoryId,
      phone:phone.text,
      businessId: businessId,
      email: email.text,
      customerName: name.text,
      comment: comment.text,
      image: image,
      city: city.text,
      country: country.text,
      customerFeedBacks: customerFeedback
    ),businessOwnerId,businessName,context).then((response){
      if(response.statusCode==200||response.statusCode==201) {
        city.text = "";
        country.text = "";
        name.text = "";
        phone.text = "";
        email.text = "";
        image = "";
        comment.text = "";
        customerFeedback.clear();
      }
     // Navigator.pop(context);
    });
  }
 void getFeedBack(int businessId,BuildContext context){
    _feedbackRepository.getFeedBack(0, 0, businessId,null,context).then((value){
      feedbacks.clear();
      feedbacks.assignAll(value);
    });
  }
void getFeedBackByEmail(BuildContext context){
   if(_accountController.getLoggedInUserData().userInfo.email!=null){
     _feedbackRepository.getFeedBack(0, 0,0,_accountController.getLoggedInUserData().userInfo.email, context).then((value){
       feedbacks.clear();
       feedbacks.assignAll(value);
     });
   }
}
void getFeedBackforCustomer(int businessId,BuildContext context){
  _feedbackRepository.getFeedbackforCustomer(0, 0, businessId,null,context).then((value){
    feedbacks.clear();
    feedbacks.assignAll(value);
  });
}
  @override
  void onClose() {
    comment?.dispose();
    phone?.dispose();
    email?.dispose();
    name?.dispose();
    city?.dispose();
    country?.dispose();
  }
}