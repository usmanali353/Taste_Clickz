import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/Controllers/CategoryController.dart';
import 'package:review_app/Controllers/SubCategoryController.dart';
import 'package:review_app/components/colorConstants.dart';

class AddBusinessSubCategory extends StatefulWidget {
  int businessId,categoryId;

  AddBusinessSubCategory(this.businessId,this.categoryId);

  @override
  _AddBusinessSubCategoryState createState() => _AddBusinessSubCategoryState();
}

class _AddBusinessSubCategoryState extends State<AddBusinessSubCategory> {
  final subcategoriesController=Get.find<SubCategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Business Sub Category",
          style: GoogleFonts.prompt(
            textStyle: TextStyle(
                color: color4,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        iconTheme: IconThemeData(
            color: color4
        ),
        centerTitle: true,
        backgroundColor: color3,
      ),
      body: Container(
        color: color4,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Container(
                  child: TextFormField(
                    controller: subcategoriesController.subCategoryName,
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color1,
                          //fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    obscureText: false,
                    validator: (String value) =>
                    value.isEmpty ? "This field is Required" : null,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color3, width: 1.0)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: color6, width: 1.0)
                      ),
                      labelText: "Sub Category Name",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            color: color3,
                            //fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                subcategoriesController.addSubCategory(context,widget.categoryId,widget.businessId);
              },
              child: Center(
                child: Card(
                  elevation: 6,
                  color: color3,
                  child: Container(
                    height: 55,
                    width: 220,
                    decoration: BoxDecoration(
                      color: color3,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("SAVE",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color4,
                              //fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
