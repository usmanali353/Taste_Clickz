import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_resume/need_resume.dart';
import 'package:review_app/AppScreens/Admin/BusinessCategory/AddBusinessCategory.dart';
import 'package:review_app/AppScreens/Admin/BusinessCategory/UpdateBusinessCategory.dart';
import 'package:review_app/AppScreens/Admin/BusinessSubcategory/BusinessSubCategoryList.dart';
import 'package:review_app/Controllers/AccountController.dart';
import 'package:review_app/Controllers/CategoryController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class BusinessCategoryList extends StatefulWidget {
  int businessId;
  BusinessCategoryList(this.businessId);
  @override
  _BusinessCategoryListState createState() => _BusinessCategoryListState();
}

class _BusinessCategoryListState extends ResumableState<BusinessCategoryList> {
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
    final _accountController =Get.find<AccountController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          _accountController.getLoggedInUserData().role=="Admin"?
          IconButton(
            icon: Icon(Icons.add, color: color4,size:25,),
            onPressed: (){
              push(context,MaterialPageRoute(builder:(context)=>AddBusinessCategory(widget.businessId)));
            },
          ):Container()
        ],
        title: Text("Business Category",
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
              categoriesController.getCategories(context, widget.businessId);
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
                child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.20,
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        icon: Icons.edit,
                        color: color2,
                        caption: 'Update',
                        onTap: () async {
                          push(context,MaterialPageRoute(builder:(context)=>UpdateBusinessCategory(categoriesController.categoryList[index])));
                        },
                      ),
                      IconSlideAction(
                        icon: categoriesController.categoryList[index].isVisible?Icons.visibility_off:Icons.visibility,
                        color: Colors.red,
                        caption: 'Visibility',
                        onTap: () async {
                          categoriesController.changeVisibility(categoriesController.categoryList[index].id, widget.businessId, context);
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
                            print(categoriesController.categoryList[index].id);
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>BusinessSubCategoryList(widget.businessId,categoriesController.categoryList[index].id)));
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
