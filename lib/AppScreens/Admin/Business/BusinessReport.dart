
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:review_app/Controllers/FeedbackController.dart';
import 'package:review_app/Controllers/OverallReportController.dart';
import 'package:review_app/Utils/Utils.dart';
import 'package:review_app/components/colorConstants.dart';

class BusinessReport extends StatefulWidget {
  int businessId;

  BusinessReport(this.businessId);

  @override
  _BusinessReportState createState() => _BusinessReportState();
}

class _BusinessReportState extends State<BusinessReport> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final _reportController = Get.put(OverallReportController());
  Map<String, double> dataMap = {
    "Positive Rating": 0,
    "Negative Rating": 0,
  };
  List<Color> colorList = [
    Colors.green,
    Colors.red,
    Colors.red,
  ];
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
        title: Text("Dashboard",
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
              _reportController.getOverallReport(widget.businessId, 30, context);
            }
          });
      },
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:Obx((){
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Monthly Report",
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: color1,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                          Visibility(
                          visible: _reportController.dataMap!=null,
                            child: PieChart(
                              dataMap: _reportController.dataMap!=null&&_reportController.dataMap.isNotEmpty?_reportController.dataMap:dataMap,
                              chartType: ChartType.disc,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: 20,
                              chartRadius: MediaQuery.of(context).size.width / 2.7,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              ringStrokeWidth: 32,
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendTextStyle: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: color1,
                                      //fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                              ),
                            ),
                          ),
                            ],
                          ) ;
                        })
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
