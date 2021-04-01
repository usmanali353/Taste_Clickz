// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:charts_flutter/flutter.dart' as charts;
// // import 'package:horse_management/HMS/Dashboard/dashboard_services/user_dashboard_json.dart';
// // import 'package:horse_management/Model/breedingControlStatus.dart';
// // import 'package:horse_management/Model/incomeExpenses.dart';
// // import 'package:horse_management/Model/trainingStatus.dart';
// // import 'package:horse_management/Utils.dart';
// // import 'package:pie_chart/pie_chart.dart';
// // import 'package:progress_dialog/progress_dialog.dart';
// class GraphDashboard extends StatefulWidget{
//   String token;
//   GraphDashboard(this.token);
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return GraphDashboardState(token);
//   }
//
// }
// class GraphDashboardState extends State<GraphDashboard>{
//   String token;
//   var dashboard_data;
//   GraphDashboardState(this.token);
//   List<charts.Series> seriesList,seriesList2,seriesLineList;
//   List<charts.Series<trainingStatus, String>> trainingStatusData;
//   List<charts.Series<breedingControlStatus,String>> breedingControlStatusData;
//   List<charts.Series<incomeExpenses,int>> incomeExpensesData;
//   Map<String, double> dataMap;
//   bool isVisible=false;
//   List<Color> colorList = [
//     Colors.red,
//     Colors.yellow,
//     Colors.green,
//   ];
//   @override
//   void initState() {
//     dataMap = new Map();
//     Utils.check_connectivity().then((result){
//       if(result){
//         ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
//         pd.show();
//         DashboardServices.getUserDashboardData(token).then((response){
//           pd.dismiss();
//           if(response!=null){
//             setState(() {
//               dashboard_data=json.decode(response);
//               dataMap.putIfAbsent("Males", () => dashboard_data['males']!=null?double.parse(dashboard_data['males'].toString()):0);
//               dataMap.putIfAbsent("Females", () => dashboard_data['females']!=null?double.parse(dashboard_data['females'].toString()):0);
//               dataMap.putIfAbsent("Gieldings", () => dashboard_data['gieldings']!=null?double.parse(dashboard_data['gieldings'].toString()):0);
//               isVisible=true;
//               List<trainingStatus> trainingStatusList=[
//                 trainingStatus("Bad",dashboard_data['trainingStatusBad']!=null?dashboard_data['trainingStatusBad']:0),
//                 trainingStatus("Satisfy",dashboard_data['trainingStatusSatisfy']!=null?dashboard_data['trainingStatusSatisfy']:0),
//                 trainingStatus("Good",dashboard_data['trainingStatusGood']!=null?dashboard_data['trainingStatusGood']:0),
//                 trainingStatus("Excellent",dashboard_data['trainingStatusExcellent']!=null?dashboard_data['trainingStatusExcellent']:0),
//               ];
//               List<breedingControlStatus> breedingControlStatusList=[
//                 breedingControlStatus("Bad",dashboard_data['breedingControlBad']!=null?dashboard_data['breedingControlBad']:0),
//                 breedingControlStatus("Satisfy",dashboard_data['breedingControlSatisfy']!=null?dashboard_data['breedingControlSatisfy']:0),
//                 breedingControlStatus("Good",dashboard_data['breedingControlGood']!=null?dashboard_data['breedingControlGood']:0),
//                 breedingControlStatus("Excellent",dashboard_data['breedingControlExcellent']!=null?dashboard_data['breedingControlExcellent']:0),
//               ];
//               trainingStatusData=[
//                 charts.Series<trainingStatus, String>(
//                   domainFn: (trainingStatus status, _) => status.statusName,
//                   measureFn: (trainingStatus status, _) => status.statusValue,
//                   data: trainingStatusList,
//                   id: "Training Status",
//                   fillColorFn: (trainingStatus status, _) {
//                     return charts.MaterialPalette.teal.shadeDefault;
//                   },
//                 )
//               ];
//               breedingControlStatusData=[
//                 charts.Series<breedingControlStatus, String>(
//                   domainFn: (breedingControlStatus status, _) => status.BreedingControlStatusName,
//                   measureFn: (breedingControlStatus status, _) => status.BreedingControlStatusValue,
//                   data: breedingControlStatusList,
//                   id: "Breeding Control Status",
//                   fillColorFn: (breedingControlStatus status, _) {
//                     return charts.MaterialPalette.teal.shadeDefault;
//                   },
//                 )
//               ];
//               List<incomeExpenses> incomeList=[
//                 incomeExpenses(1,double.parse(dashboard_data['incomes'][0].toString())),
//                 incomeExpenses(2,double.parse(dashboard_data['incomes'][1].toString())),
//                 incomeExpenses(3,double.parse(dashboard_data['incomes'][2].toString())),
//                 incomeExpenses(4,double.parse(dashboard_data['incomes'][3].toString())),
//                 incomeExpenses(5,double.parse(dashboard_data['incomes'][4].toString())),
//                 incomeExpenses(6,double.parse(dashboard_data['incomes'][5].toString())),
//                 incomeExpenses(7,double.parse(dashboard_data['incomes'][6].toString())),
//                 incomeExpenses(8,double.parse(dashboard_data['incomes'][7].toString())),
//                 incomeExpenses(9,double.parse(dashboard_data['incomes'][8].toString())),
//                 incomeExpenses(10,double.parse(dashboard_data['incomes'][9].toString())),
//                 incomeExpenses(11,double.parse(dashboard_data['incomes'][10].toString())),
//                 incomeExpenses(12,double.parse(dashboard_data['incomes'][11].toString())),
//               ];
//               List<incomeExpenses> expensesList=[
//                 incomeExpenses(1,double.parse(dashboard_data['expenses'][0].toString())),
//                 incomeExpenses(2,double.parse(dashboard_data['expenses'][1].toString())),
//                 incomeExpenses(3,double.parse(dashboard_data['expenses'][2].toString())),
//                 incomeExpenses(4,double.parse(dashboard_data['expenses'][3].toString())),
//                 incomeExpenses(5,double.parse(dashboard_data['expenses'][4].toString())),
//                 incomeExpenses(6,double.parse(dashboard_data['expenses'][5].toString())),
//                 incomeExpenses(7,double.parse(dashboard_data['expenses'][6].toString())),
//                 incomeExpenses(8,double.parse(dashboard_data['expenses'][7].toString())),
//                 incomeExpenses(9,double.parse(dashboard_data['expenses'][8].toString())),
//                 incomeExpenses(10,double.parse(dashboard_data['expenses'][9].toString())),
//                 incomeExpenses(11,double.parse(dashboard_data['expenses'][10].toString())),
//                 incomeExpenses(12,double.parse(dashboard_data['expenses'][11].toString())),
//               ];
//
//               incomeExpensesData=[
//                 charts.Series<incomeExpenses,int>(
//                   domainFn: (incomeExpenses status, _) => status.month,
//                   measureFn: (incomeExpenses status, _) => status.value,
//                   data: incomeList,
//                   id: "Income",
//                   fillColorFn: (incomeExpenses status, _) {
//                     return charts.MaterialPalette.teal.shadeDefault;
//                   },
//                 ),
//                 charts.Series<incomeExpenses, int>(
//                   domainFn: (incomeExpenses status, _) => status.month,
//                   measureFn: (incomeExpenses status, _) => status.value,
//                   data: expensesList,
//                   id: "Expenses",
//                   fillColorFn: (incomeExpenses status, _) {
//                     return charts.MaterialPalette.teal.shadeDefault;
//                   },
//                 )
//               ];
//               seriesList=trainingStatusData;
//               seriesList2=breedingControlStatusData;
//               seriesLineList=incomeExpensesData;
//             });
//           }
//         });
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Scrollbar(
//           child: ListView(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Visibility(
//                     visible: isVisible,
//                     child: Container(
//                       margin: EdgeInsets.all(8),
//                       child: Card(
//                         elevation:5.0,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(top:8,bottom:8),
//                               child:Center(child: Text("Horses by Gender",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
//                             ),
//                             PieChart(
//                               dataMap: dataMap,
//                               animationDuration: Duration(milliseconds: 800),
//                               chartLegendSpacing: 32.0,
//                               chartRadius: MediaQuery.of(context).size.width / 2.7,
//                               showChartValuesInPercentage: true,
//                               showChartValues: true,
//                               showChartValuesOutside: false,
//                               chartValueBackgroundColor: Colors.grey[200],
//                               colorList: colorList,
//                               showLegends: true,
//                               legendPosition: LegendPosition.right,
//                               decimalPlaces: 1,
//                               showChartValueLabel: true,
//                               initialAngle: 0,
//                               chartValueStyle: defaultChartValueStyle.copyWith(
//                                 color: Colors.blueGrey[900].withOpacity(0.9),
//                               ),
//                               chartType: ChartType.disc,
//                             ),
//                           ],
//
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: isVisible,
//                     child: Container(
//                       margin: EdgeInsets.all(8),
//                       height:MediaQuery.of(context).size.height/2.7,
//                       child: Card(
//                         elevation:5.0,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(top:8,bottom:8),
//                               child:Center(child: Text("Horses by Trainings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
//                             ),
//                             Expanded(
//                                 child: charts.BarChart(
//                                   seriesList,
//                                   animate: true,
//                                   vertical: true,
//                                   domainAxis:  charts.OrdinalAxisSpec(
//                                       renderSpec:  charts.SmallTickRendererSpec(
//                                         // Tick and Label styling here.
//                                           labelStyle:  charts.TextStyleSpec(// size in Pts.
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)),
//
//                                           // Change the line colors to match text color.
//                                           lineStyle: new charts.LineStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)))),
//                                   primaryMeasureAxis: new charts.NumericAxisSpec(
//                                       renderSpec: new charts.GridlineRendererSpec(
//                                         // Tick and Label styling here.
//                                           labelStyle: new charts.TextStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)),
//                                           // Change the line colors to match text color.
//                                           lineStyle: new charts.LineStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)))),
//                                 )
//                             ),
//
//                           ],
//
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: isVisible,
//                     child: Container(
//                       margin: EdgeInsets.all(8),
//                       height:MediaQuery.of(context).size.height/2.7,
//                       child: Card(
//                         elevation:5.0,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(top:8,bottom:8),
//                               child:Center(child: Text("Horses by Breeding",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
//                             ),
//                             Expanded(
//                                 child: charts.BarChart(
//                                   seriesList2,
//                                   animate: true,
//                                   vertical: false,
//                                   domainAxis:  charts.OrdinalAxisSpec(
//                                       renderSpec:  charts.SmallTickRendererSpec(
//                                         // Tick and Label styling here.
//                                           labelStyle:  charts.TextStyleSpec(// size in Pts.
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)),
//
//                                           // Change the line colors to match text color.
//                                           lineStyle: new charts.LineStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)))),
//                                   primaryMeasureAxis: new charts.NumericAxisSpec(
//                                       renderSpec: new charts.GridlineRendererSpec(
//                                         // Tick and Label styling here.
//                                           labelStyle: new charts.TextStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)),
//                                           // Change the line colors to match text color.
//                                           lineStyle: new charts.LineStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)))),
//                                 )
//                             ),
//
//                           ],
//
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: isVisible,
//                     child: Container(
//                       margin: EdgeInsets.all(8),
//                       height:MediaQuery.of(context).size.height/2.7,
//                       child: Card(
//                         elevation:5.0,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(top:8,bottom:8),
//                               child:Center(child: Text("Income and Expenses",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
//                             ),
//                             Expanded(
//                                 child: charts.LineChart(
//                                   seriesLineList,
//                                   animate: true,
//                                   behaviors: [
//                                     new charts.ChartTitle('Months',titleStyleSpec: charts.TextStyleSpec(color: charts.ColorUtil.fromDartColor(Colors.grey)),
//                                         behaviorPosition: charts.BehaviorPosition.bottom,
//                                         titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
//                                     new charts.ChartTitle('Income Expenses',titleStyleSpec: charts.TextStyleSpec(color: charts.ColorUtil.fromDartColor(Colors.grey)),
//                                         behaviorPosition: charts.BehaviorPosition.start,
//                                         titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
//                                   ],
//                                   domainAxis:  charts.NumericAxisSpec(
//                                       renderSpec:  charts.SmallTickRendererSpec(
//                                         // Tick and Label styling here.
//                                           labelStyle:  charts.TextStyleSpec(// size in Pts.
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)),
//
//                                           // Change the line colors to match text color.
//                                           lineStyle: new charts.LineStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)))),
//                                   primaryMeasureAxis: new charts.NumericAxisSpec(
//                                       renderSpec: new charts.GridlineRendererSpec(
//                                         // Tick and Label styling here.
//                                           labelStyle: new charts.TextStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)),
//                                           // Change the line colors to match text color.
//                                           lineStyle: new charts.LineStyleSpec(
//                                               color: charts.ColorUtil.fromDartColor(Colors.grey)))),
//                                 )
//                             ),
//
//                           ],
//
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//             ],
//
//           ),
//         )
//     );
//   }
//
// }