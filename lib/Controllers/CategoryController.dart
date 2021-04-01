import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/Interfaces/ICategoryRepository.dart';
import 'package:review_app/Models/CategoriesViewModel.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/Utils/Utils.dart';

class CategoryController extends GetxController{
 TextEditingController categoryName;
 var _categoryRepository=locator<ICategoryRepository>();
 var categoryList=<CategoriesViewModel>[].obs;
  @override
  void onInit() {
    if(categoryName==null) {
      categoryName = TextEditingController();
    }
  }
 void getCategories(BuildContext context,int businessId){
    _categoryRepository.getCategories(businessId, context).then((categoriesList){
      categoryList.clear();
      categoryList.assignAll(categoriesList);
    });
  }
 void addCategories(BuildContext context,int businessId){
    if(categoryName.text.isEmpty){
      Utils.showError(context,"Category Name is Required");
    }else {
      _categoryRepository.addCategories(CategoriesViewModel(
        id: 0,
        name: categoryName.text,
        businessId: businessId,
        categoryId: 0,
      ), context).then((response){
        if(response.statusCode==200||response.statusCode==201) {
          categoryName.text = "";
        }
      });
    }
  }
 void UpdateCategories(CategoriesViewModel model,BuildContext context){
   if(categoryName.text.isEmpty){
     Utils.showError(context,"Category Name is Required");
   }else {
     _categoryRepository.updateCategories(model.id,model, context).then((response){
       if(response.statusCode==200||response.statusCode==204) {
         categoryName.text = "";
       }
     });
   }
 }
  void changeVisibility(int id,int businessId,BuildContext context){
    _categoryRepository.changeVisibility(id, context).then((value){
      getCategories(context, businessId);
    });
  }

  void getCategoriesforCustomer(BuildContext context,int businessId){
    _categoryRepository.getCategoriesforCustomer(businessId, context).then((categoriesList){
      categoryList.clear();
      categoryList.assignAll(categoriesList);
    });
  }
  @override
  void onClose() {
    categoryName?.dispose();
  }
}