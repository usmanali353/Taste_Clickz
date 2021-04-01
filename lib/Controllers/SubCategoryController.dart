import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:review_app/Interfaces/ISubCategoryRepository.dart';
import 'package:review_app/Models/CategoriesViewModel.dart';
import 'package:review_app/Utils/Locator.dart';
import 'package:review_app/Utils/Utils.dart';

class SubCategoryController extends GetxController{
  TextEditingController subCategoryName;
  var subcategoryList=<CategoriesViewModel>[].obs;
  var _subCategoryRepository=locator<ISubCategoryRepository>();
  @override
  void onInit() {
    if(subCategoryName==null) {
      subCategoryName = TextEditingController();
    }
    super.onInit();
  }
  void addSubCategory(BuildContext context,int categoryId,int businessId){
    if(subCategoryName.text.isEmpty){
      Utils.showError(context,"Sub Category Name is Required");
    }else{
      _subCategoryRepository.addSubCategories(CategoriesViewModel(
        id: 0,
        categoryId: categoryId,
        businessId: businessId,
        name: subCategoryName.text
      ), context).then((response){
        if(response.statusCode==200||response.statusCode==201) {
          subCategoryName.text = "";
        }
      });
    }
   }
  void getSubCategory(int categoryId,BuildContext context){
    _subCategoryRepository.getSubCategories(categoryId, context).then((value){
      subcategoryList.clear();
      subcategoryList.assignAll(value);
    });
  }
  void changeVisibility(int id,int categoryId,BuildContext context){
    _subCategoryRepository.changeVisibility(id, context).then((value){
      getSubCategory(categoryId,context);
    });
  }
  void getSubCategoryforCustomer(int categoryId,BuildContext context){
    _subCategoryRepository.getSubCategoriesforCustomer(categoryId, context).then((value){
      subcategoryList.clear();
      subcategoryList.assignAll(value);
    });
  }
  void UpdateSubCategories(CategoriesViewModel model,BuildContext context){
    _subCategoryRepository.updateSubCategories(model.id,model, context).then((response){
      if(response.statusCode==200||response.statusCode==204){
        subCategoryName.text="";
      }
    });
  }
  @override
  void onClose() {
    subCategoryName?.dispose();
    super.onClose();
  }
}