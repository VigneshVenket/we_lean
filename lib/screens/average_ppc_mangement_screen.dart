import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/average_ppc_bargraph/average_ppc_bargraph_bloc.dart';
import 'package:we_lean/bloc/average_ppc_bargraph/average_ppc_bargraph_event.dart';
import 'package:we_lean/bloc/average_ppc_bargraph/average_ppc_bargraph_state.dart';
import 'package:we_lean/bloc/average_ppc_data/average_ppc_data_bloc.dart';
import 'package:we_lean/bloc/average_ppc_data/average_ppc_data_event.dart';
import 'package:we_lean/bloc/average_ppc_data/average_ppc_data_state.dart';
import 'package:we_lean/bloc/daywise_ppc_list/daywise_ppc_list_event.dart';
import 'package:we_lean/widgets/custom_appbar.dart';

import '../bloc/daywise_ppc_list/daywise_ppc_list_bloc.dart';
import '../repo/daywise_ppc_list_repo.dart';
import '../utils/colors.dart';
import '../utils/shared_pref_service.dart';
import '../utils/styles.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/custom_route.dart';
import 'daywise_ppc_management_screen.dart';




class AveragePPCManagementSscreen extends StatefulWidget {
  const AveragePPCManagementSscreen({Key? key}) : super(key: key);

  @override
  _AveragePPCManagementSscreenState createState() => _AveragePPCManagementSscreenState();
}

class _AveragePPCManagementSscreenState extends State<AveragePPCManagementSscreen> {
  int weeknumber=0;
  int currentweekHome=0;
  String ?_startWeek;

  @override
  void initState() {
    // TODO: implement initState
    _initializeData();
    BlocProvider.of<AveragePPCBargraphBloc>(context).add(FetchAveragePPCBargraphEvent());
    BlocProvider.of<AveragePPCDataBloc>(context).add(FetchAveragePPCDataEvent());
    super.initState();
  }

  Future<void> _initializeData() async {
    final sharedPreferencesService = await SharedPreferencesService.instance;
    final String? retrievedStartWeek = sharedPreferencesService.startWeek;
    setState(() {
      _startWeek = retrievedStartWeek;
      weeknumber = getWeekOfYear(DateTime.now());
      // Calculate current week based on start week
      if (_startWeek != null) {
        currentweekHome = weeknumber - int.parse(_startWeek!) + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Week - $currentweekHome"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Overall PPC Summary",style:  titilliumBold ,),
            SizedBox(height: 10,),
            BlocBuilder<AveragePPCBargraphBloc, AveragePPCBargraphState>(
              builder: (context, state) {
                if (state is AveragePPCBargraphLoaded) {
                  final countData = state.data;

                  if (countData != null) {
                    print(countData.keys.toList()[0]);
                    print(countData.values.toList());
                    final List<int> intList=countData.values.toList();
                    final List<double> doubleList = intList.map((value) => value.toDouble()).toList();
                    print(doubleList);

                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                            children:[
                              Positioned(
                                  top:MediaQuery.of(context).size.height*0.16,
                                  left: 2.0,
                                  child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Text("[ % ]",style: titilliumSemiBold.copyWith(),))),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 100, // Adjusted maxY value
                                    barTouchData: BarTouchData(enabled: false),
                                    gridData: FlGridData(
                                        show: false
                                    ),
                                    titlesData: FlTitlesData(
                                      leftTitles: const AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            interval: 20.0,
                                            reservedSize: 40,

                                          )
                                        // showTitles: true,
                                        // interval: 20.0,
                                        // reservedSize: 30,
                                        // getTextStyles: (context, value) => titilliumBoldRegular,
                                      ),
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value,title){
                                                // return Text(" ");
                                                switch (value.toInt()) {
                                                  case 0:
                                                    return Text("Mon",);
                                                  case 1:
                                                    return Text("Tue",);
                                                  case 2:
                                                    return Text("Wed",);
                                                  case 3:
                                                    return Text("Thur",);
                                                  case 4:
                                                    return Text("Fri",);
                                                  case 5:
                                                    return Text("Sat",);
                                                  case 6:
                                                    return Text("Sun",);
                                                  default:
                                                    return Text(" ");
                                                }

                                              }
                                          )
                                      ),
                                      topTitles: const AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false
                                          )
                                      ),
                                      rightTitles: const AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false
                                          )
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    barGroups: List.generate(
                                      doubleList.length,
                                          (index) => BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(toY: doubleList[index], color: CustomColors.themeColor, width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]

                        ),
                      ),
                    );
                  } else {
                    return  Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                top:MediaQuery.of(context).size.height*0.12,
                                left: 2.0,
                                child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text("[ Percentage ]",style: titilliumSemiBold.copyWith(letterSpacing: 1.0,color: CustomColors.themeColor),))),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: 100, // Adjusted maxY value
                                  barTouchData: BarTouchData(enabled: false),
                                  gridData: FlGridData(
                                    show: false
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 20.0,
                                          reservedSize: 40,

                                        )
                                      // showTitles: true,
                                      // interval: 20.0,
                                      // reservedSize: 30,
                                      // getTextStyles: (context, value) => titilliumBoldRegular,
                                    ),
                                    bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value,title){
                                              // return Text(" ");
                                              switch (value.toInt()) {
                                                case 0:
                                                  return Text("Mon",style: titilliumRegular,);
                                                case 1:
                                                  return Text("Tue",style: titilliumRegular,);
                                                case 2:
                                                  return Text("Wed",style: titilliumRegular,);
                                                case 3:
                                                  return Text("Thur",style: titilliumRegular,);
                                                case 4:
                                                  return Text("Fri",style: titilliumRegular,);
                                                case 5:
                                                  return Text("Sat",style: titilliumRegular,);
                                                case 6:
                                                  return Text("Sun",style: titilliumRegular,);
                                                default:
                                                  return Text(" ");
                                              }

                                            }
                                        )
                                    ),
                                    topTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: false
                                        )
                                    ),
                                    rightTitles: const AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: false
                                        )
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  barGroups: List.generate(
                                    7,
                                        (index) => BarChartGroupData(
                                      x: index,
                                      barRods: [
                                        BarChartRodData(toY: 0, color: CustomColors.themeColor, width: 10),
                                      ],
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

                }else if(state is AveragePPCBargraphError){
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.40,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(240, 240, 240, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              top:MediaQuery.of(context).size.height*0.12,
                              left: 2.0,
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text("[ Percentage ]",style: titilliumSemiBold.copyWith(letterSpacing: 1.0,color: CustomColors.themeColor),))),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                          //   child: BarChart(
                          //     BarChartData(
                          //       alignment: BarChartAlignment.spaceAround,
                          //       maxY: 100, // Adjusted maxY value
                          //       barTouchData: BarTouchData(enabled: false),
                          //       titlesData: FlTitlesData(
                          //         leftTitles: SideTitles(
                          //           showTitles: true,
                          //           interval: 20.0,
                          //           reservedSize: 30,
                          //           getTextStyles: (context, value) => titilliumBoldRegular,
                          //         ),
                          //         bottomTitles: SideTitles(
                          //           showTitles: true,
                          //           getTextStyles: (context, value) => titilliumBoldRegular,
                          //           margin: 16,
                          //           getTitles: (double value) {
                          //             switch (value.toInt()) {
                          //               case 0:
                          //                 return 'Mon';
                          //               case 1:
                          //                 return 'Tue';
                          //               case 2:
                          //                 return 'Wed';
                          //               case 3:
                          //                 return 'Thu';
                          //               case 4:
                          //                 return 'Fri';
                          //               case 5:
                          //                 return 'Sat';
                          //               case 6:
                          //                 return 'Sun';
                          //               default:
                          //                 return '';
                          //             }
                          //           },
                          //         ),
                          //       ),
                          //       borderData: FlBorderData(show: false),
                          //       barGroups: List.generate(
                          //         7,
                          //             (index) => BarChartGroupData(
                          //           x: index,
                          //           barRods: [
                          //             BarChartRodData(y: 0, colors: [CustomColors.themeColor], width: 10),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],

                      ),
                    ),
                  );
                }
                else {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: CustomColors.themeColor,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 10,),
            BlocBuilder<AveragePPCDataBloc,AveragePPCDataState>(
              builder: (context,state){
                if(state is AveragePPCDataLoaded){
                  if(state.data!=null){
                    final weekPlanIds=state.data.weekPlanIds.join(",");
                    print(weekPlanIds);
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.95,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 28,
                                      height:28,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: CustomColors.themeColorOpac
                                      ),
                                      child: Icon(Icons.task_alt_sharp,color: Colors.white,size: 20,)),
                                  Text("Activties Planned",style:titilliumRegular,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(240, 240, 240, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("${state.data.totalPlanned}",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 28,
                                      height:28,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: CustomColors.themeColorOpac
                                      ),
                                      child: Icon(Icons.add_task_sharp,color: Colors.white,size: 20,)),
                                  Text("Activities Achieved",style:titilliumRegular,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(240, 240, 240, 1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("${state.data!.totalActual}",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(

                                onTap: (){
                                  CustomNavigation.push(context,  BlocProvider(
                                  create: (BuildContext context) {
                                    return DayWisePPCBloc(daywisePpcListRepo:RealDaywisePpcListRepo())
                                      ..add(FetchDayWisePPCListManagement(weekPlanIds: weekPlanIds));
                                  },
                                  child:DaywisePPCListManagement(weekPlanIds: weekPlanIds,),
                                ));
                                },
                                child:
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  decoration: BoxDecoration(
                                      color: CustomColors.themeColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width:MediaQuery.of(context).size.width*0.2,),
                                      Text("PPC",style:titilliumBold.copyWith(color: Colors.white)),
                                      SizedBox(width:MediaQuery.of(context).size.width*0.36,),
                                      Text("${state.data.totalPPC}%",style: titilliumBold.copyWith(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                    return  Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.95,
                        height: MediaQuery.of(context).size.height*0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 28,
                                      height:28,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: CustomColors.themeColorOpac
                                      ),
                                      child: Icon(Icons.task_alt_sharp,color: Colors.white,size: 20,)),
                                  Text("Activties Planned",style:titilliumRegular,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(240, 240, 240, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("0",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 28,
                                      height:28,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: CustomColors.themeColorOpac
                                      ),
                                      child: Icon(Icons.add_task_sharp,color: Colors.white,size: 20,)),
                                  Text("Activities Achieved",style:titilliumRegular,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(240, 240, 240, 1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("0",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (){},
                                child:
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  decoration: BoxDecoration(
                                      color: CustomColors.themeColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width:MediaQuery.of(context).size.width*0.2,),
                                      Text("PPC",style:titilliumBold.copyWith(color: Colors.white)),
                                      SizedBox(width:MediaQuery.of(context).size.width*0.36,),
                                      Text("0%",style: titilliumBold.copyWith(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                }else if(state is AveragePPCDataError){
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      height: MediaQuery.of(context).size.height*0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 28,
                                    height:28,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: CustomColors.themeColorOpac
                                    ),
                                    child: Icon(Icons.task_alt_sharp,color: Colors.white,size: 20,)),
                                Text("Activties Planned",style:titilliumRegular,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(child: Text("0",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 28,
                                    height:28,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: CustomColors.themeColorOpac
                                    ),
                                    child: Icon(Icons.add_task_sharp,color: Colors.white,size: 20,)),
                                Text("Activities Achieved",style:titilliumRegular,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.4,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(240, 240, 240, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text("0",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: (){},
                              child:
                              Container(
                                width: MediaQuery.of(context).size.width*0.9,
                                height: MediaQuery.of(context).size.height*0.05,
                                decoration: BoxDecoration(
                                    color: CustomColors.themeColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width*0.2,),
                                    Text("PPC",style:titilliumBold.copyWith(color: Colors.white)),
                                    SizedBox(width:MediaQuery.of(context).size.width*0.36,),
                                    Text("0%",style: titilliumBold.copyWith(color: Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                else{
                  return Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.themeColor,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  int getWeekOfYear(DateTime date) {
    int dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    int weekOfYear = ((dayOfYear - date.weekday + 10) / 7).floor() + 1;
    if (weekOfYear < 1) {
      weekOfYear = getWeekOfYear(DateTime(date.year - 1, 12, 31)); // Previous year's last week
    } else if (weekOfYear > 52) {
      // Check if this is week 1 of the next year
      DateTime nextYear = DateTime(date.year + 1, 1, 1);
      if (nextYear.weekday <= DateTime.thursday) {
        weekOfYear = 1;
      }
    }
    return weekOfYear-1;
  }
}
