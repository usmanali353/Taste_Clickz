import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:review_app/AppScreens/Admin/BusinessCategory/AddBusinessCategory.dart';
import 'package:review_app/AppScreens/Admin/BusinessSubcategory/BusinessSubCategoryList.dart';
import 'package:review_app/AppScreens/Customer/ReviewCategory/SelectReviewSubCategory.dart';
import 'package:review_app/Controllers/CategoryController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class SelectReviewCategoryList extends StatefulWidget {
  int businessId;
  SelectReviewCategoryList(this.businessId);
  @override
  _SelectReviewCategoryListState createState() => _SelectReviewCategoryListState();
}

class _SelectReviewCategoryListState extends ResumableState<SelectReviewCategoryList> {
  final categoriesController=Get.put(CategoryController());
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
        title: Text("Select Review Category",
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
              categoriesController.getCategoriesforCustomer(context, widget.businessId);
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
            return ListView.builder(itemCount:categoriesController.categoryList!=null?categoriesController.categoryList.length:0, itemBuilder: (context, index){
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
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>SelectReviewSubCategoryList(widget.businessId,categoriesController.categoryList[index].id)));
                      },
                      title: Text(categoriesController.categoryList!=null&&categoriesController.categoryList[index].name!=null?categoriesController.categoryList[index].name:"-",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              color: color3,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      leading: FaIcon(
                        FontAwesomeIcons.conciergeBell,
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
