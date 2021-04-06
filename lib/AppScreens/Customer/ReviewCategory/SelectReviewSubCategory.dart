import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/AddRating.dart';
import 'package:review_app/AppScreens/Admin/Feedbacks/CustomerInfoforFeedback.dart';
import 'package:review_app/Controllers/SubCategoryController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class SelectReviewSubCategoryList extends StatefulWidget {
  var categoryId,businessId,businessOwnerId,businessName;
  SelectReviewSubCategoryList(this.businessId,this.categoryId,this.businessOwnerId,this.businessName);
  @override
  _SelectReviewSubCategoryListState createState() => _SelectReviewSubCategoryListState();
}

class _SelectReviewSubCategoryListState extends ResumableState<SelectReviewSubCategoryList> {
  final subCategoriesController=Get.put(SubCategoryController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }
  @override
  void onResume() {
    if(resume.data=="Refresh"){
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    }
    super.onResume();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Review Sub Category",
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
              subCategoriesController.getSubCategoryforCustomer(widget.categoryId,context);
            }else{
              Utils.showError(context,"Network not Available");
            }
          });
        },
        child: Container(
          color: color4,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Obx((){
            return ListView.builder(itemCount:subCategoriesController.subcategoryList!=null?subCategoriesController.subcategoryList.length:0, itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 6,
                    color: color4,
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
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>CustomerInfoForFeedback(businessId:widget.businessId,subcategoryId:subCategoriesController.subcategoryList[index].id,categoryId: widget.categoryId,businessOwnerId: widget.businessOwnerId,businessName: widget.businessName,)));
                      },
                      title: Text(subCategoriesController.subcategoryList!=null&&subCategoriesController.subcategoryList[index].name!=null?subCategoriesController.subcategoryList[index].name:"-",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color3,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      leading: FaIcon(
                        FontAwesomeIcons.medal,
                        size: 30,
                        color: color3,
                      ),
                    ),
                  ),
                ),
              );
            });
          }),
        ),
      ),
    );
  }
}
