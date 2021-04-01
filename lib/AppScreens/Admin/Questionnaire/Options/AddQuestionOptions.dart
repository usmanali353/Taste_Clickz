import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/Controllers/CategoryController.dart';
import 'package:review_app/Controllers/QuestionOptionsController.dart';
import 'package:review_app/components/colorConstants.dart';

class AddQuestionOptions extends StatefulWidget {
  int questionId;

  AddQuestionOptions(this.questionId);

  @override
  _AddBusinessCategoryState createState() => _AddBusinessCategoryState();
}

class _AddBusinessCategoryState extends State<AddQuestionOptions> {
  final optionController=Get.put(QuestionOptionsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Business Category",
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
                    controller: optionController.questionOptionText,
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color1,
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
                      labelText: "Option Text",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            color: color3,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Container(
                  child: TextFormField(
                    controller: optionController.value,
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: color1,
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
                      labelText: "Option Value",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            color: color3,
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
                optionController.AddQuestionOptions(widget.questionId,context);
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
                              fontSize: 22,
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
