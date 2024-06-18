import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/average_ppc_bargraph/average_ppc_bargraph_bloc.dart';
import 'package:we_lean/bloc/average_ppc_data/average_ppc_data_bloc.dart';
import 'package:we_lean/bloc/bar_chart_ppc/bar_chart_ppc_bloc.dart';
import 'package:we_lean/bloc/bar_chart_ppc/bar_chart_ppc_event.dart';
import 'package:we_lean/bloc/bar_chart_ppc/bar_chart_ppc_state.dart';
import 'package:we_lean/bloc/daywise_ppc_list/daywise_ppc_list_bloc.dart';
import 'package:we_lean/bloc/daywise_ppc_list/daywise_ppc_list_event.dart';
import 'package:we_lean/bloc/line_chart_variance_data/line_chart_variance_data_bloc.dart';
import 'package:we_lean/bloc/line_chart_variance_data/line_chart_variance_data_event.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_bloc.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_event.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_state.dart';
import 'package:we_lean/bloc/posts/post_bloc.dart';
import 'package:we_lean/bloc/today_plan/toay_plan_event.dart';
import 'package:we_lean/bloc/today_plan/today_plan_bloc.dart';
import 'package:we_lean/bloc/today_plan/today_plan_state.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_bloc.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_event.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_state.dart';
import 'package:we_lean/repo/average_ppc_bargraph_repo.dart';
import 'package:we_lean/repo/average_ppc_data_repo.dart';
import 'package:we_lean/repo/daywise_ppc_list_repo.dart';
import 'package:we_lean/repo/line_chart_variance_data_repo.dart';
import 'package:we_lean/repo/posts_repo.dart';
import 'package:we_lean/screens/add_post_screen.dart';
import 'package:we_lean/screens/average_ppc_mangement_screen.dart';
import 'package:we_lean/screens/location_display_screen.dart';
import 'package:we_lean/screens/plan_approval_screen.dart';
import 'package:we_lean/screens/ppc_summary_week.dart';
import 'package:we_lean/screens/profile%20_screen_v2.dart';
import 'package:we_lean/screens/profile_screen_manager.dart';
import 'package:we_lean/screens/profile_screen_mangement.dart';
import 'package:we_lean/screens/root_cause_analysis_weekly.dart';
import 'package:we_lean/screens/variance_daily.dart';
import 'package:we_lean/screens/variance_screen.dart';
import 'package:we_lean/screens/variance_weekly.dart';
import 'package:we_lean/utils/app_config.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/location/location_bloc.dart';
import '../bloc/user_location_plan/user_location_plan_bloc.dart';
import '../repo/location_repo.dart';
import '../repo/user_location_plan_repo.dart';
import '../utils/shared_pref_service.dart';
import 'actions_daily_screen.dart';
import 'actions_week_screen.dart';
import 'logout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<int, bool> actionPerformedMap = {};


  String ?_startWeek;
  String ?projectLocationName;
  int weeknumber=0;
  int currentweekHome=0;

  String ?formattedMonday;
  String ?formattedSunday;


  // int touchedIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"? BlocProvider.of<WeekVariancePPCBloc>(context).add(FetchWeekVariancePPCData(userId: AppData.user!.id!)):
    BlocProvider.of<WeekVariancePPCBloc>(context).add(FetchWeekVariancePPCDataLocationwise(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));
    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"? BlocProvider.of<TodayPlanBloc>(context).add(FetchTodayPlan(userId: AppData.user!.id!)):
    BlocProvider.of<TodayPlanBloc>(context).add(FetchTodayPlanLocationwise(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));

    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?BlocProvider.of<BarChartBloc>(context).add(FetchBarChartDataEvent(userId: AppData.user!.id!)):
    BlocProvider.of<BarChartBloc>(context).add(FetchBarChartDataLocationwiseEvent(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));

    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?BlocProvider.of<OverallPPCBloc>(context).add(FetchOverallPPCDataEvent(userId: AppData.user!.id!)):
    BlocProvider.of<OverallPPCBloc>(context).add(FetchOverallPPCDataLocationwiseEvent(userId: AppData.user!.id!,projLocId: AppData.projectLocation!.id));
    actionPerformedMap = {};
    super.initState();
    _initializeData();
  }



  Future<void> _initializeData() async {
    final sharedPreferencesService = await SharedPreferencesService.instance;
    final String? retrievedStartWeek = sharedPreferencesService.startWeek;
    final String? retrievedProjectLocationName=sharedPreferencesService.projectLocationName;
    setState(() {
      _startWeek = retrievedStartWeek;
      weeknumber = getWeekOfYear(DateTime.now());
      // Calculate current week based on start week
      if (_startWeek != null) {
        currentweekHome = weeknumber - int.parse(_startWeek!) + 1;
      }
      projectLocationName=retrievedProjectLocationName;
      print(projectLocationName);
    });
  }

  calculate_fromandtodates(){
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    DateTime sunday = monday.add(Duration(days: 6));

    formattedMonday = DateFormat('dd-MM-yy').format(monday);
    formattedSunday = DateFormat('dd-MM-yy').format(sunday);

    print('Current week starts on: $formattedMonday');
    print('Current week ends on: $formattedSunday');
  }



  @override
  Widget build(BuildContext context) {
    calculate_fromandtodates();
    print(projectLocationName);

    final GlobalKey<ScaffoldState> _key = GlobalKey();

        return Scaffold(
          key: _key,
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.1,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Image.asset("assets/images/We Lean New Logo 16-08-2023.png",fit: BoxFit.fill,),
                ),
                SizedBox(width: 5,),
                Text("WE LEAN",style:titilliumTitle.copyWith(color: Colors.black),)
              ],
            ),

            actions: [
              IconButton(
                icon: Icon(Icons.menu, size: 26,color: Colors.black),
                onPressed: () {
                  _key.currentState?.openEndDrawer();
                },
              ),
            ],
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          endDrawer:
          AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
              getEngineerDrawer(context):AppData.user!.role_name=="Construction Manager"?
              getManegerDrawer(context):getManagementDrawer(context),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Location",style:  titilliumBold ,),
                      // SizedBox(width: MediaQuery.of(context).size.width*0.52,),
                      // Text("Week No",style:  titilliumBold ,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.949,
                          height: MediaQuery.of(context).size.height*0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Color.fromRGBO(240, 240, 240, 1)),
                          child: Row(
                            children: [
                              Container(
                                width:40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                                ),
                                child: Icon(Icons.location_pin,color: CustomColors.themeColorOpac,size: 24,),),
                              SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                              Text(projectLocationName!,style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),)
                              // AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?Text("${projectLocationName?.split('-')[1].trim()}",
                              //     style:titilliumBoldRegular.copyWith(color: CustomColors.themeColor)):
                              // Text("${AppData.projectLocation!.name}",
                              //     style:titilliumBoldRegular.copyWith(color: CustomColors.themeColor))
                            ],
                          ),
                        ),
                        onTap: (){

                        },
                      ):
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.949,
                          height: MediaQuery.of(context).size.height*0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Color.fromRGBO(240, 240, 240, 1)),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width:40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:Theme.of(context).brightness==Brightness.dark?
                                  Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                                ),
                                child: Icon(Icons.location_pin,color: CustomColors.themeColorOpac,size: 24,),),
                              // SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                              // AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?Container(
                              //   width: MediaQuery.of(context).size.width*0.75,
                              //   child: Text("${AppData.user!.projectLocation!.description.split('-')[1].trim()}",
                              //       style:titilliumBoldRegular.copyWith(color: CustomColors.themeColor)),
                              // ):
                              Container(
                                width: MediaQuery.of(context).size.width*0.75,
                                child: Text("${AppData.projectLocation!.name}",
                                    style:titilliumBoldRegular.copyWith(color: CustomColors.themeColor)),
                              ),

                              // SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                              Icon(Icons.arrow_drop_down_sharp,size: 30,color: CustomColors.themeColorOpac,)
                            ],
                          ),
                        ),
                        onTap: (){
                          CustomNavigation.pushAndRemoveUntill(context,
                              // BlocProvider(
                              //   create: (BuildContext context) {
                              //     return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
                              //       ..add(FetchWeekVariancePPCData(userId: AppData.user!.id!));
                              //   },
                              // child: MainScreen(),
                              // ),
                              MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (BuildContext context) {
                                        return LocationsBloc(locationRepo: RealLocationRepo());
                                      },),
                                  ],
                                  child: LocationScreen()
                              )
                          );
                        },
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width*0.07),
                      // Container(
                      //   width: MediaQuery.of(context).size.width*0.225,
                      //   height: MediaQuery.of(context).size.height*0.05,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color:Color.fromRGBO(240, 240, 240, 1)),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width:40,
                      //         height: 40,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color:Theme.of(context).brightness==Brightness.dark?
                      //           Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                      //         ),
                      //         child: Icon(Icons.calendar_today,color: CustomColors.themeColorOpac,size: 24,),),
                      //       SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      //       Text("${currentweekHome}",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),)
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text("Location",style:  titilliumBold ,),

                      Text("Week No",style:  titilliumBold ,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.085,),
                      Text("From",style:  titilliumBold ,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.24,),
                      Text("To",style:  titilliumBold ,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.23,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Color.fromRGBO(240, 240, 240, 1)),
                        child: Row(
                          children: [
                            Container(
                              width:40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Theme.of(context).brightness==Brightness.dark?
                                Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                              ),
                              child: Icon(Icons.weekend,color: CustomColors.themeColorOpac,size: 24,),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                            Text("${currentweekHome}",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),)
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.33,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Color.fromRGBO(240, 240, 240, 1)),
                        child: Row(
                          children: [
                            Container(
                              width:40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Theme.of(context).brightness==Brightness.dark?
                                Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                              ),
                              child: Icon(Icons.calendar_today,color: CustomColors.themeColorOpac,size: 24,),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.014,),
                            Text(formattedMonday!,style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),)
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.33,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Color.fromRGBO(240, 240, 240, 1)),
                        child: Row(
                          children: [
                            Container(
                              width:40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:Theme.of(context).brightness==Brightness.dark?
                                Color.fromRGBO(18, 18, 18, 1):Color.fromRGBO(240, 240, 240, 1),
                              ),
                              child: Icon(Icons.calendar_today,color: CustomColors.themeColorOpac,size: 24,),),
                            SizedBox(width: MediaQuery.of(context).size.width*0.0014,),
                            Text(formattedSunday!,style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("PPC Summary",style:  titilliumBold ,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.18,),
                      AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?
                          Container():GestureDetector(
                            onTap: (){
                              CustomNavigation.push(context,  MultiBlocProvider(
                                providers: [

                                  BlocProvider(
                                    create: (BuildContext context) {
                                      return AveragePPCBargraphBloc(RealAveragePPCBargraphRepo());

                                    },),
                                  BlocProvider(
                                    create: (BuildContext context) {
                                      return AveragePPCDataBloc(RealAveragePPCDataRepo());
                                    },),
                                ],
                                child: AveragePPCManagementSscreen() ,
                              ),);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height*0.05,
                              decoration: BoxDecoration(
                                color: CustomColors.themeColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                   Text("View Overall PPC",style: titilliumBoldRegular.copyWith(color: Colors.white),),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                   Icon(Icons.arrow_forward_ios,size:16,color: Colors.white,),
                                ],
                              ),
                      ),
                          )
                    ],
                  ),
                  SizedBox(height: 10,),

                  BlocBuilder<BarChartBloc, BarChartState>(
                    builder: (context, state) {
                      if (state is BarChartLoadedState) {
                          final countData = state.barChartResponse.data?.data;
                          print(currentweekHome);
                          if (countData != null) {
                            print(countData.keys.toList()[0]);

                            print(countData.values.toList());
                            final List<String> intList=countData.values.toList();
                            final List<double> doubleList = intList.map((value) => double.parse(value)).toList();
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
                                          // bottomTitles: SideTitles(
                                          //   showTitles: true,
                                          //   getTextStyles: (context, value) => titilliumBoldRegular,
                                          //   margin: 16,
                                          //   getTitles: (double value) {
                                          //     switch (value.toInt()) {
                                          //       case 0:
                                          //         return 'Mon';
                                          //       case 1:
                                          //         return 'Tue';
                                          //       case 2:
                                          //         return 'Wed';
                                          //       case 3:
                                          //         return 'Thu';
                                          //       case 4:
                                          //         return 'Fri';
                                          //       case 5:
                                          //         return 'Sat';
                                          //       case 6:
                                          //         return 'Sun';
                                          //       default:
                                          //         return '';
                                          //     }
                                          //   },
                                          // ),
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
                                  ),]

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

                      }else if(state is BarChartErrorState){
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
                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                                 child: BarChart(
                                   BarChartData(
                                     alignment: BarChartAlignment.spaceAround,
                                     maxY: 100, // Adjusted maxY value
                                     barTouchData: BarTouchData(enabled: false),
                                     titlesData: FlTitlesData(
                                       // leftTitles: SideTitles(
                                       //   showTitles: true,
                                       //   interval: 20.0,
                                       //   reservedSize: 30,
                                       //   getTextStyles: (context, value) => titilliumBoldRegular,
                                       // ),
                                       // bottomTitles: SideTitles(
                                       //   showTitles: true,
                                       //   getTextStyles: (context, value) => titilliumBoldRegular,
                                       //   margin: 16,
                                       //   getTitles: (double value) {
                                       //     switch (value.toInt()) {
                                       //       case 0:
                                       //         return 'Mon';
                                       //       case 1:
                                       //         return 'Tue';
                                       //       case 2:
                                       //         return 'Wed';
                                       //       case 3:
                                       //         return 'Thu';
                                       //       case 4:
                                       //         return 'Fri';
                                       //       case 5:
                                       //         return 'Sat';
                                       //       case 6:
                                       //         return 'Sun';
                                       //       default:
                                       //         return '';
                                       //     }
                                       //   },
                                       // ),
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

                  BlocBuilder<OverallPPCBloc,OverallPPCState>(
                    builder: (context,state){
                       if(state is OverallPPCLoadedState){
                         if(state.overallPPCResponse.data!=null){
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
                                           child: Center(child: Text("${state.overallPPCResponse.data!.totalPlanned}",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
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
                                             child: Center(child: Text("${state.overallPPCResponse.data!.totalActual}",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                                           ),
                                         )
                                       ],
                                     ),
                                     GestureDetector(
                                       onTap: (){CustomNavigation.push(context,  BlocProvider(
                                         create: (BuildContext context) {
                                           return DayWisePPCBloc(daywisePpcListRepo:RealDaywisePpcListRepo())
                                             ..add(FetchDayWisePPC(weekPlanId: state.overallPPCResponse.data!.weekPlanId));
                                         },
                                         child:PPCSummaryWeek(week_plan_id: state.overallPPCResponse.data!.weekPlanId) ,
                                       ));},
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
                                             Text("${state.overallPPCResponse.data!.totalPPC}%",style: titilliumBold.copyWith(color: Colors.white),),
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

                       }else if(state is OverallPPCErrorState){
                         return Text(state.error);
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

                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  Text("Variance Status",style:  titilliumBold ,),
                  SizedBox(height: 10,),
                  BlocBuilder<WeekVariancePPCBloc, WeekVariancePPCState>(
                    builder: (context, state) {
                      if (state is WeekVariancePPCDataLoaded) {
                        final countData = state.weekVariancePPCResponse.data;
                        // print(countData);
                        final countList = countData?.values.map((dayData) => dayData.count).toList() ?? [];
                        // print(countList);

                        final varianceIdsList = countData?.values.map((dayData) => dayData.varianceLogIds.join(',')).toList() ?? [];
                        // print('Variance IDs list: $varianceIdsList');
                        // print('${varianceIdsList.isNotEmpty}');


                        bool actionPerformed = false;



                        return
                          Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.32,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: LineChart(
                              LineChartData(
                                minX: -1,
                                maxX: 7,
                                minY: -0.2,
                                maxY: countList.isNotEmpty ? countList.reduce((a, b) => a > b ? a : b).toDouble() + 1 : 1,
                                titlesData: FlTitlesData(
                                  // bottomTitles: SideTitles(
                                  //   showTitles: true,
                                  //   margin: 0,
                                  //   getTextStyles: (context, value) => titilliumBoldRegular,
                                  //   getTitles: (value) {
                                  //     switch (value.toInt()) {
                                  //       case 0:
                                  //         return 'Mon';
                                  //       case 1:
                                  //         return 'Tue';
                                  //       case 2:
                                  //         return 'Wed';
                                  //       case 3:
                                  //         return 'Thu';
                                  //       case 4:
                                  //         return 'Fri';
                                  //       case 5:
                                  //         return 'Sat';
                                  //       case 6:
                                  //         return 'Sun';
                                  //       default:
                                  //         return '';
                                  //     }
                                  //   },
                                  // ),
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
                                  leftTitles:AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false
                                    )
                                  ),
                                  rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false
                                      )
                                  ),
                                  topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false
                                      )
                                  ),
                                ),
                                borderData: FlBorderData(show: false, border: Border.all(color: Colors.grey)),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: List.generate(
                                      countList.length,
                                          (index) => FlSpot(index.toDouble(), countList[index].toDouble()),
                                    ),
                                    isCurved: true,
                                    color: CustomColors.themeColor,
                                    barWidth: 4,
                                    isStrokeCapRound: true,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                        radius: 4,
                                        color: Colors.red, // Change the dot color here
                                        strokeWidth: 2,
                                        strokeColor: Colors.red, // Change the border color here
                                      ),
                                    ),
                                  ),
                                ],
                                gridData: FlGridData(
                                  show: false,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey, // Change the color of horizontal grid lines here
                                      strokeWidth: 2, // Adjust the width as needed
                                    );
                                  },
                                ),
                                lineTouchData: LineTouchData(
                                  touchTooltipData: LineTouchTooltipData(
                                      getTooltipColor: (LineBarSpot touchedSpot) {
                                        return Color.fromRGBO(240, 240, 240, 1);
                                      }
                                  ),

                                  // touchCallback: (LineTouchResponse touchResponse) {
                                  //   final spot = touchResponse.lineBarSpots![0];
                                  //   final dayIndex = spot.x.toInt();
                                  //   if (!actionPerformedMap.containsKey(dayIndex) || !actionPerformedMap[dayIndex]!) {
                                  //     if (countData != null && countData.isNotEmpty) {
                                  //       final dayData = countData.values.elementAt(dayIndex);
                                  //       // print("Variance log ids ${dayData.varianceLogIds.isNotEmpty}");
                                  //
                                  //       if (dayData.varianceLogIds.isNotEmpty) {
                                  //         final varianceIds = dayData.varianceLogIds.join(',');
                                  //         // print('Variance IDs for tapped day: $varianceIds');
                                  //
                                  //         CustomNavigation.push(context, BlocProvider(
                                  //           create: (BuildContext context) {
                                  //             return LineChartVarianceBloc(RealLineChartVarianceDataRepo())
                                  //               ..add(FetchLineChartVarianceData(varianceId: varianceIds));
                                  //           },
                                  //           child: VarianceScreen(varianceIds: varianceIds),
                                  //         ));
                                  //       } else {
                                  //         // print("Pressed");
                                  //         CustomMessenger.showMessage(context, "No variance data available for the day", Colors.red);
                                  //       }
                                  //       // Mark the action as performed for this day
                                  //       actionPerformedMap[dayIndex] = true;
                                  //     }
                                  //   }
                                  // },
                                ),

                          ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.32,
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
                  Divider(),

                  Text("Today's Activity",style:  titilliumBold ,),
                  SizedBox(height: 10,),

                  BlocBuilder<TodayPlanBloc,TodayPlanState>(
                    builder: (context,state){
                       if(state is TodayPlanLoaded){
                         if(state.todayPlanResponse.data!.isNotEmpty){
                           return Container(
                             width: MediaQuery.of(context).size.width*0.95,
                             height: MediaQuery.of(context).size.height*0.22,
                             child: ListView.builder(
                                 scrollDirection:Axis.horizontal ,
                                 shrinkWrap: true,
                                 // physics: NeverScrollableScrollPhysics(),
                                 itemCount: state.todayPlanResponse.data!.length,
                                 itemBuilder: (context,index){
                                   return Row(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(5.0),
                                         child: Container(
                                             width: MediaQuery.of(context).size.width*0.47,
                                             height: MediaQuery.of(context).size.height*0.2,
                                             decoration: const BoxDecoration(
                                               color:Color.fromRGBO(240,240,240,1),
                                               // border: Border.all(color: Color.fromRGBO(
                                               //     219, 204, 204, 1.0)),
                                             ),
                                             child: Column(
                                               mainAxisAlignment:MainAxisAlignment.start,
                                               crossAxisAlignment:CrossAxisAlignment.start,
                                               children: [
                                                 ClipRRect(
                                                   borderRadius:BorderRadius.circular(10),
                                                   child: Container(
                                                       width: MediaQuery.of(context).size.width*0.47,
                                                       height: MediaQuery.of(context).size.height*0.14,
                                                       child: Image(
                                                         image: NetworkImage("${AppConfig.plan_url}/${state.todayPlanResponse.data![index].activity.activityImage}"),
                                                         fit: BoxFit.fill,
                                                       )
                                                   ),
                                                 ),
                                                 SizedBox(height: 7,),
                                                 Row(
                                                   children: [
                                                     Container(
                                                         width: 32,
                                                         height:32,
                                                         decoration: BoxDecoration(
                                                             borderRadius: BorderRadius.circular(5),
                                                             color: CustomColors.themeColorOpac
                                                         ),
                                                         child: Icon(Icons.construction_sharp,size: 20,color: Colors.white,)),
                                                     SizedBox(width: MediaQuery.of(context).size.width*0.03),
                                                     Container(
                                                       width: MediaQuery.of(context).size.width*0.33,
                                                       child: Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                                           Text(state.todayPlanResponse.data![index].activity.name,style: titilliumRegular,overflow: TextOverflow.ellipsis,),
                                                           Text(state.todayPlanResponse.data![index].plannedQty.toString()+state.todayPlanResponse.data![index].uom.name,style: titilliumRegular,),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),

                                               ],
                                             )),
                                       ),
                                     ],
                                   );
                                 }),
                           );
                         }else{
                           return Container(
                             width: MediaQuery.of(context).size.width*0.95,
                             height: MediaQuery.of(context).size.height*0.22,
                             decoration: BoxDecoration(
                               // color: Color.fromRGBO(240, 240, 240, 1),

                               borderRadius: BorderRadius.circular(10)
                             ),
                             child: Column(
                               children: [
                                  SizedBox(height: 10,),
                                  Container(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  height: MediaQuery.of(context).size.height*0.15,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Image.asset("assets/images/no plan for day.jpg",fit: BoxFit.cover,),
                                  ),
                                 SizedBox(height: 10,),
                                 Center(
                                     child: Text("No activity planned for the day",style: titilliumBold,)),
                               ],
                             ),
                           );
                         }

                       }else{
                         return Center(child: CircularProgressIndicator(
                           color: CustomColors.themeColor,
                         ));
                      }
                    },
                  )

                ],
              ),
            ),
          ),
        );

  }

  Widget CustomDisplayContainer(Color color,String text,String count,IconData icon){
    return Container(

        width: MediaQuery.of(context).size.width*0.46,
        height: MediaQuery.of(context).size.height*0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
        ),
      child: Center(
        child: Row(
          children: [
            SizedBox(width: 10,),
            Icon(icon,color: Colors.white,size: 28,),
            SizedBox(height: 15,),
            Container(
              width:MediaQuery.of(context).size.width*0.3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(count,style: titilliumBold.copyWith(color: Colors.white),),
                    SizedBox(height: 2,),
                    Text(text,style: titilliumSemiBold.copyWith(color: Colors.white),),
                  ],
                ),
              ),
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

  Widget CustomListProfileTile(String title,IconData icon,){
    return    ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color:CustomColors.themeColorOpac,
            borderRadius: BorderRadius.circular(10)
        ),
        child:Icon(icon,color: Colors.white,) ,
      ),
      title: Text(title,style: titilliumSemiBold,),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14,),
    );
  }

  Widget getEngineerDrawer(BuildContext context){
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.12,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey),
                          color: CustomColors.themeColorOpac
                      ),
                      child: Icon(Icons.person_sharp,size: 20,color: Colors.white,),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppData.user!.name!,style: titilliumBoldRegular.copyWith(color: Colors.black)),
                        SizedBox(height: 5,),
                        Text(AppData.user!.email!,style: titilliumRegular),
                        SizedBox(height: 5),
                        Text(AppData.user!.role_name!,style: titilliumRegular),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(),
              // SizedBox(height: 10,),
              // GestureDetector(
              //     onTap: (){CustomNavigation.push(context,  BlocProvider(
              //       create: (BuildContext context) {
              //         return PostBloc(RealPostsRepo());
              //       },
              //       child:AddPostScreen(),
              //     ),);},
              //     child: CustomListProfileTile("Add Posts",Icons.add_circle_outline,)),
              // SizedBox(height: 10,),
              // Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context,  BlocProvider(
                    create: (BuildContext context) {
                      return UserLocationPlanBloc(RealUserLocationPlanRepo());
                    },
                    child:  VarianceWeekly(),
                  ),);},
                  child: CustomListProfileTile("Variance", Icons.contactless_outlined)),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context,  BlocProvider(
                    create: (BuildContext context) {
                      return UserLocationPlanBloc(RealUserLocationPlanRepo());
                    },
                    child:    ActionWeekScreen(),
                  ),);},
                  child: CustomListProfileTile("Actions",Icons.grading,)),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context,  BlocProvider(
                    create: (BuildContext context) {
                      return UserLocationPlanBloc(RealUserLocationPlanRepo());
                    },
                    child: RootCauseAnalysisWeekly(),
                  ),);},
                  child: CustomListProfileTile("Rootcause Analysis",Icons.compass_calibration_outlined)),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context, LogoutScreen());},
                  child: CustomListProfileTile("Logout", Icons.logout)),
              SizedBox(height: 20,),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
  Widget getManegerDrawer(BuildContext context){
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.12,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey),
                          color: CustomColors.themeColorOpac
                      ),
                      child: Icon(Icons.person_sharp,size: 20,color: Colors.white,),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppData.user!.name!,style: titilliumBoldRegular.copyWith(color: Colors.black)),
                        SizedBox(height: 5,),
                        Text(AppData.user!.email!,style: titilliumRegular),
                        SizedBox(height: 5),
                        Text(AppData.user!.role_name!,style: titilliumRegular),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 20,),
              // GestureDetector(
              //     onTap: (){CustomNavigation.push(context,  BlocProvider(
              //       create: (BuildContext context) {
              //         return PostBloc(RealPostsRepo());
              //       },
              //       child:AddPostScreen(),
              //     ),);},
              //     child: CustomListProfileTile("Add Posts",Icons.add_circle_outline,)),
              // SizedBox(height: 20,),
              // Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context,  BlocProvider(
                    create: (BuildContext context) {
                      return UserLocationPlanBloc(RealUserLocationPlanRepo());
                    },
                    child:    ActionWeekScreen(),
                  ),);},
                  child: CustomListProfileTile("Actions",Icons.grading,)),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context,  BlocProvider(
                    create: (BuildContext context) {
                      return UserLocationPlanBloc(RealUserLocationPlanRepo());
                    },
                    child: RootCauseAnalysisWeekly(),
                  ),);},
                  child: CustomListProfileTile("Rootcause Analysis",Icons.compass_calibration_outlined)),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context, LogoutScreen());},
                  child: CustomListProfileTile("Logout", Icons.logout)),
              SizedBox(height: 20,),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
  Widget getManagementDrawer(BuildContext context){
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.12,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey),
                          color: CustomColors.themeColorOpac
                      ),
                      child: Icon(Icons.person_sharp,size: 20,color: Colors.white,),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppData.user!.name!,style: titilliumBoldRegular.copyWith(color: Colors.black)),
                        SizedBox(height: 5,),
                        Text(AppData.user!.email!,style: titilliumRegular),
                        SizedBox(height: 5),
                        Text(AppData.user!.role_name!,style: titilliumRegular),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Divider(),
              // SizedBox(height: 20,),
              // GestureDetector(
              //     onTap: (){CustomNavigation.push(context,  BlocProvider(
              //       create: (BuildContext context) {
              //         return PostBloc(RealPostsRepo());
              //       },
              //       child:AddPostScreen(),
              //     ),);},
              //     child: CustomListProfileTile("Add Posts",Icons.add_circle_outline,)),
              // SizedBox(height: 20,),
              // Divider(),
              // SizedBox(height: 20,),
              // AppData.user!.role_name=="Project Director"?Column(
              //   children: [
              //     GestureDetector(
              //         onTap: (){
              //           CustomNavigation.push(context,  MultiBlocProvider(
              //             providers: [
              //
              //               BlocProvider(
              //                 create: (BuildContext context) {
              //                   return AveragePPCBargraphBloc(RealAveragePPCBargraphRepo());
              //
              //                 },),
              //               BlocProvider(
              //                 create: (BuildContext context) {
              //                   return AveragePPCDataBloc(RealAveragePPCDataRepo());
              //                 },),
              //             ],
              //             child: AveragePPCManagementSscreen() ,
              //           ),);
              //
              //           },
              //         child: CustomListProfileTile("Overall PPC", Icons.graphic_eq)),
              //     SizedBox(height: 20,),
              //     Divider(),
              //   ],
              // ):Container(),
              SizedBox(height: 20,),

              GestureDetector(
                  onTap: (){CustomNavigation.push(context,  BlocProvider(
                    create: (BuildContext context) {
                      return UserLocationPlanBloc(RealUserLocationPlanRepo());
                    },
                    child: RootCauseAnalysisWeekly(),
                  ),);},
                  child: CustomListProfileTile("Rootcause Analysis",Icons.compass_calibration_outlined)),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: (){CustomNavigation.push(context, LogoutScreen());},
                  child: CustomListProfileTile("Logout", Icons.logout)),
              SizedBox(height: 20,),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

