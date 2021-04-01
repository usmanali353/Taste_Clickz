import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:review_app/Models/CategoriesViewModel.dart';
abstract class ISubCategoryRepository{
  Future<List<CategoriesViewModel>> getSubCategories(int categoryId,BuildContext context);
  Future<List<CategoriesViewModel>> getSubCategoriesforCustomer(int categoryId,BuildContext context);
  Future<Response> addSubCategories(CategoriesViewModel categoriesViewModel,BuildContext context);
  Future<void> changeVisibility(int id,BuildContext context);
  Future<Response> updateSubCategories(int id,CategoriesViewModel categoriesViewModel,BuildContext context);
}