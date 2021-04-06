import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:review_app/Interfaces/IAccountRepository.dart';
import 'package:review_app/Models/BusinessViewModel.dart';
import 'package:review_app/Models/LoginViewModel.dart';
import 'package:review_app/Models/RegisterViewModel.dart';
import 'package:review_app/Models/TokenPayLoad.dart';
import 'package:review_app/Utils/Locator.dart';
import '../Models/LoginViewModel.dart';
import '../Models/RegisterViewModel.dart';
import '../Utils/Utils.dart';

class AccountController extends GetxController{
 var accountRepository =locator<IAccountRepository>();
 bool isVisible=true;
 bool signUpPasswordIsVisible=true;
 TextEditingController confirmPasswordTextEditingController, nameTextEditingController,emailTextEditingController,passwordTextEditingController,cityTextEditingController,countryTextEditingController,phoneTextEditingController;
 @override
  void onInit() {
   if(emailTextEditingController==null){
     emailTextEditingController=TextEditingController();
   }
   if(passwordTextEditingController==null){
     passwordTextEditingController=TextEditingController();
   }
   if(confirmPasswordTextEditingController==null){
     confirmPasswordTextEditingController=TextEditingController();
   }
   if(nameTextEditingController==null) {
     nameTextEditingController = TextEditingController();
   }
   if(phoneTextEditingController==null) {
     phoneTextEditingController = TextEditingController();
   }
   if(cityTextEditingController==null) {
     cityTextEditingController = TextEditingController();
   }
   if(countryTextEditingController==null) {
     countryTextEditingController = TextEditingController();
   }

  }

  Future<String> AuthenticateUser(BuildContext context)async{
    Utils.check_connectivity().then((isConnected){
      if(isConnected){
        if(emailTextEditingController.text==null||emailTextEditingController.text.isEmpty){
          Utils.showError(context, "Email is Required");
        }else if(!Utils.validateEmail(emailTextEditingController.text)){
          Utils.showError(context, "Email Format is Invalid");
        }
        else if(passwordTextEditingController.text==null||passwordTextEditingController.text.isEmpty){
          Utils.showError(context, "Password is Required");
        }else if(!Utils.validateStructure(passwordTextEditingController.text)){
          Utils.showError(context, "Password must contain atleast one lower case,Upper case and special characters");
        }else {
          return accountRepository.login(context, LoginViewModel(
              email: emailTextEditingController.text,
              password: passwordTextEditingController.text,
              confirmPassword: passwordTextEditingController.text)).then((response){
                if(response.statusCode==200) {
                  nameTextEditingController.text = "";
                  emailTextEditingController.text = "";
                  passwordTextEditingController.text = "";
                  phoneTextEditingController.text = "";
                  cityTextEditingController.text = "";
                  countryTextEditingController.text = "";
                }
          });
        }
      }else
        Utils.showError(context,"Network not Available");
    });

  }
   ResetPassword(BuildContext context){
    if(emailTextEditingController.text==null||emailTextEditingController.text.isEmpty){
      Utils.showError(context, "Email is Required");
    }else if(!Utils.validateEmail(emailTextEditingController.text)){
      Utils.showError(context, "Email Format is Invalid");
    } else if(passwordTextEditingController.text==null||passwordTextEditingController.text.isEmpty){
      Utils.showError(context, "Password is Required");
    }else if(!Utils.validateStructure(passwordTextEditingController.text)) {
      Utils.showError(context, "Password must contain atleast one lower case,Upper case and special characters");
    }else if(confirmPasswordTextEditingController.text==null||confirmPasswordTextEditingController.text.isEmpty){
      Utils.showError(context, "Confirm Password is Required");
    }else if(!Utils.validateStructure(confirmPasswordTextEditingController.text)){
      Utils.showError(context, "Confirm Password must contain atleast one lower case,Upper case and special characters");
    }else if(passwordTextEditingController.text!=confirmPasswordTextEditingController.text){
      Utils.showError(context, "Both Passwords should match");
    }else{
      accountRepository.resetPassword(context, LoginViewModel(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text,
          confirmPassword: confirmPasswordTextEditingController.text
      )).then((response){
        if(response.statusCode==200){
          emailTextEditingController.text="";
          passwordTextEditingController.text="";
          confirmPasswordTextEditingController.text="";
        }
      });
    }
  }
  Future<void> RegisterUser(BuildContext context,BusinessViewModel businessViewModel) {
    if (nameTextEditingController.text == null || nameTextEditingController.text.isEmpty) {
      Utils.showError(context, "Name Required");
    } else if (emailTextEditingController.text == null || emailTextEditingController.text.isEmpty) {
      Utils.showError(context, "Email Required");
    } else if (!Utils.validateEmail(emailTextEditingController.text)) {
      Utils.showError(context, "Email Not Valid");
    } else if (passwordTextEditingController.text == null || passwordTextEditingController.text.isEmpty) {
      Utils.showError(context, "Password Required");
    } else if (!Utils.validateStructure(passwordTextEditingController.text)) {
      Utils.showError(context, "password contain 1 upper case 1 num and 1 special chracter");
    } else if (phoneTextEditingController.text == null || phoneTextEditingController.text.isEmpty) {
      Utils.showError(context, "Phone is Required");
    } else if (cityTextEditingController.text == null || cityTextEditingController.text.isEmpty) {
      Utils.showError(context, "City is Required");
    } else if (countryTextEditingController.text == null || countryTextEditingController.text.isEmpty) {
      Utils.showError(context, "Country is Required");
    } else {
      return accountRepository.register(context, RegisterViewModel(
          name: nameTextEditingController.text,
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text,
          phone: phoneTextEditingController.text,
          country: countryTextEditingController.text,
          city: cityTextEditingController.text,
          businessViewModel: businessViewModel
      )).then((response){
        if(response.statusCode==200){
          nameTextEditingController.text="";
          emailTextEditingController.text="";
          passwordTextEditingController.text="";
          phoneTextEditingController.text="";
          cityTextEditingController.text="";
          countryTextEditingController.text="";
        }
      });
    }
  }
  Future<void> updateProfile(BuildContext context){
    if (nameTextEditingController.text == null || nameTextEditingController.text.isEmpty) {
      Utils.showError(context, "Name Required");
    } else if (emailTextEditingController.text == null || emailTextEditingController.text.isEmpty) {
      Utils.showError(context, "Email Required");
    } else if (!Utils.validateEmail(emailTextEditingController.text)) {
      Utils.showError(context, "Email Not Valid");
    } else if (passwordTextEditingController.text == null || passwordTextEditingController.text.isEmpty) {
      Utils.showError(context, "Password Required");
    } else if (!Utils.validateStructure(passwordTextEditingController.text)) {
      Utils.showError(context, "password contain 1 upper case 1 num and 1 special chracter");
    } else if (phoneTextEditingController.text == null || phoneTextEditingController.text.isEmpty) {
      Utils.showError(context, "Phone is Required");
    } else if (cityTextEditingController.text == null || cityTextEditingController.text.isEmpty) {
      Utils.showError(context, "City is Required");
    } else if (countryTextEditingController.text == null || countryTextEditingController.text.isEmpty) {
      Utils.showError(context, "Country is Required");
    } else {
      locator<Logger>().w(getLoggedInUserData().userInfo.id);
      return accountRepository.updateProfile(context, RegisterViewModel(
          name: nameTextEditingController.text,
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text,
          phone: phoneTextEditingController.text,
          country: countryTextEditingController.text,
          city: cityTextEditingController.text,
          userId: getLoggedInUserData().userInfo.id
      )).then((value){
        AuthenticateUser(context);
      });
    }
  }

  TokenPayLoad getLoggedInUserData(){
   print(locator<GetStorage>().read("token")!=null);
   if(locator<GetStorage>().read("token")!=null) {
     return TokenPayLoad.fromJson(
         Utils.parseJwt(locator<GetStorage>().read("token")));
   }else
     return null;
  }

  @override
  void onClose() {
    nameTextEditingController?.dispose();
    emailTextEditingController?.dispose();
    passwordTextEditingController?.dispose();
    phoneTextEditingController?.dispose();
    cityTextEditingController?.dispose();
    countryTextEditingController?.dispose();
  }

  @override
  void dispose() {
   this.dispose();
    super.dispose();
  }
}