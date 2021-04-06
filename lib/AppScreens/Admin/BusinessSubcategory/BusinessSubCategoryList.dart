import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:review_app/AppScreens/Admin/BusinessSubcategory/UpdateBusinessSubCategory.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/CustomerInfoforFeedback.dart';
import 'package:review_app/AppScreens/Admin/Questionnaire/QuestionnaireList.dart';
import 'AddBusinessSubCategory.dart';
import 'package:review_app/Controllers/SubCategoryController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class BusinessSubCategoryList extends StatefulWidget {
  var businessId,categoryId;

  BusinessSubCategoryList(this.businessId, this.categoryId);

  @override
  _BusinessSubCategoryListState createState() => _BusinessSubCategoryListState();
}

class _BusinessSubCategoryListState extends ResumableState<BusinessSubCategoryList> {
  @override
  void onResume() {
    super.onResume();
    if(resume.data=="Refresh"){
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    }
  }

  final subCategoryController=Get.put(SubCategoryController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: color4,size:25,),
            onPressed: (){
              push(context, MaterialPageRoute(builder: (context)=> AddBusinessSubCategory(widget.businessId,widget.categoryId)));
            },
          ),
        ],
        title: Text("Business Subcategory",
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: ()async{
          return Utils.check_connectivity().then((isConnected){
            if(isConnected){
              subCategoryController.getSubCategory(widget.categoryId, context);
            }else{
              Utils.showError(context,"Network not Available");
            }
          });
        },
        child: Container(
          color: color4,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx((){
            return ListView.builder(itemCount:subCategoryController.subcategoryList!=null?subCategoryController.subcategoryList.length:0, itemBuilder: (context, index){
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.edit,
                        color: color2,
                        caption: 'Update',
                        onTap: () async {
                          push(context,MaterialPageRoute(builder:(context)=>UpdateBusinessSubCategory(subCategoryController.subcategoryList[index])));
                        },
                      ),
                      IconSlideAction(
                        icon: subCategoryController.subcategoryList[index].isVisible?Icons.visibility_off:Icons.visibility,
                        color: Colors.red,
                        caption: 'Visibility',
                        onTap: () {
                          subCategoryController.changeVisibility(subCategoryController.subcategoryList[index].id, widget.categoryId, context);
                        },
                      ),
                    ],
                    child: Card(
                      elevation: 6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        decoration: BoxDecoration(
                          //color: color1,
                            borderRadius: BorderRadius.circular(10),
                            //border: Border.all(color: color3, width: 2)
                        ),
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>QuestionnaireList(subCategoryId: subCategoryController.subcategoryList[index].id,categoryId: subCategoryController.subcategoryList[index].categoryId,businessId: widget.businessId)));
                          },
                          title: Text(subCategoryController.subcategoryList[index].name,
                            style: GoogleFonts.prompt(
                              textStyle: TextStyle(
                                  color: color3,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                        ),
                        leading: FaIcon(
                          FontAwesomeIcons.building,
                          color: color3,
                        ),
                      ),
                  ),
                    )
              ),
              );
            });
          }),
        ),
      ),
    );
  }
}
