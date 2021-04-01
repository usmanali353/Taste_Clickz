import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:review_app/Models/Dropdown.dart';
import 'package:review_app/Models/LoginViewModel.dart';
import 'package:review_app/Models/RegisterViewModel.dart';

abstract class IAccountRepository{
 Future<Response> register(BuildContext context,RegisterViewModel registerViewModel);
 Future<Response> updateProfile(BuildContext context,RegisterViewModel registerViewModel);
 Future<Response> login (BuildContext context,LoginViewModel loginViewModel);
 Future<Response> resetPassword(BuildContext context,LoginViewModel loginViewModel);
 Future<List<Dropdown>> getRoles(BuildContext context);
}