import 'package:flutter/material.dart';
import 'package:review_app/Models/Dropdown.dart';

abstract class IBusinessTypeRepository{
 Future<Dropdown> getBusinessTypes(BuildContext context,String token);
 Future<void> changeVisibility(int id,BuildContext context);
}