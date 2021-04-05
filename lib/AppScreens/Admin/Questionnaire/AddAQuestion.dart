import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:review_app/AppScreens/Admin/Questionnaire/AddAnswers.dart';
import 'package:review_app/Controllers/QuestionsController.dart';
import 'package:review_app/components/colorConstants.dart';


class AddAQuestion extends StatefulWidget {
  int businessId,categoryId,subCategoryId;

  AddAQuestion(this.businessId, this.categoryId, this.subCategoryId);

  @override
  _AddAQuestionState createState() => _AddAQuestionState();
}

class _AddAQuestionState extends State<AddAQuestion> {

  final _questionController=Get.find<QuestionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add A Question",
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 6,
                  color: color4,
                  child: Container(
                    child: TextFormField(
                      controller: _questionController.questionText,
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
                        labelText: "Question?",
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 6,
                  color: color4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color4,
                      //border: Border.all(color: color3, width: 1)
                    ),
                    child: DropdownButtonFormField(
                      items: _questionController.reviewTypeList!=null?_questionController.reviewTypeList.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer,style: TextStyle(color: color1),),
                        value: trainer,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name",style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            color: color1,
                            //fontSize: 22,
                          ),

                          fontWeight: FontWeight.bold
                      ),
                      )))
                          .toList(),
                      decoration: InputDecoration(labelText: "Review Options",labelStyle: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            color: color3,
                            //fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: color3, width: 1.0)
                        ),
                      ),
                      onChanged: (value){
                       _questionController.questionTypeId.value=_questionController.reviewTypeList.indexOf(value)+1;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                   if(_questionController.questionTypeId.value==3){
                       Navigator.push(context,MaterialPageRoute(builder:(context)=>AddOptions(businessId: widget.businessId,subCategoryId: widget.subCategoryId,categoryId: widget.categoryId,questionTypeId: _questionController.questionTypeId.value,questionText: _questionController.questionText.text,)));
                   }else{
                     _questionController.AddQuestions(widget.businessId, widget.categoryId, widget.subCategoryId, context);
                   }
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
                        child: Text("SAVE", style: GoogleFonts.prompt(
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
      ),
    );
  }
}
