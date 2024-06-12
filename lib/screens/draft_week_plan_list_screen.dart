


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/confirm_week_plan/confirm_week_plan_bloc.dart';
import 'package:we_lean/bloc/delete_constraint/delete_constraint_bloc.dart';
import 'package:we_lean/bloc/delete_weekActivity/delete_weekactivity_bloc.dart';
import 'package:we_lean/bloc/draft_week_plan/draft_week_plan_bloc.dart';
import 'package:we_lean/bloc/draft_week_plan/draft_week_plan_event.dart';
import 'package:we_lean/bloc/draft_week_plan/draft_week_plan_state.dart';
import 'package:we_lean/repo/confirm_week_plan_repo.dart';
import 'package:we_lean/repo/delete_constraint_repo.dart';
import 'package:we_lean/repo/delete_weekactivity_repo.dart';
import 'package:we_lean/screens/drafts_week_plan_screen.dart';

import '../bloc/weekly_plan/weekly_plan_bloc.dart';
import '../repo/weekly_plan_repo.dart';
import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../utils/shared_pref_service.dart';
import '../utils/styles.dart';
import '../widgets/custom_route.dart';



class DraftWeekPlanListScreen extends StatefulWidget {

  final int projectLocationId;

  const DraftWeekPlanListScreen({required this.projectLocationId,Key? key}) : super(key: key);

  @override
  _DraftWeekPlanListScreenState createState() => _DraftWeekPlanListScreenState();
}

class _DraftWeekPlanListScreenState extends State<DraftWeekPlanListScreen> {

  // int? projectLocationId;

  @override
  void initState() {
    // TODO: implement initState
    // _initializeData();
    BlocProvider.of<DraftWeekPlanBloc>(context).add(FetchDraftWeekPlan(userId:AppData.user!.id!, proj_loc_id:widget.projectLocationId));
    super.initState();

  }

  // Future<void> _initializeData() async {
  //   final sharedPreferencesService = await SharedPreferencesService.instance;
  //   final int? retrievedProjectLocationId=sharedPreferencesService.projectLocationId;
  //   print(retrievedProjectLocationId);
  //
  //   setState(() {
  //     projectLocationId=retrievedProjectLocationId;
  //   });
  //
  //  // print(projectLocationId);
  //  // print(AppData.projectLocation!.id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text("Six Week Lookahead Plan",style: titilliumTitle.copyWith(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
          ),
          backgroundColor: Colors.white,
        ),
        body:
        BlocBuilder<DraftWeekPlanBloc,DraftWeekPlanState>(
            builder: (context,state){
              if(state is DraftWeekPlanLoaded){
                if(state.draftWeekPlans.isNotEmpty){
                  return  Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: state.draftWeekPlans.length,
                            itemBuilder: (context,index){

                              Map<String, String> separatedDates = separateDateRange(state.draftWeekPlans[index].dateRange);
                              String formattedStartDate = separatedDates['startDate']!;
                              String formattedEndDate = separatedDates['endDate']!;

                                return Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    ListTile(
                                      leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: CustomColors.themeColorOpac
                                          ),
                                          child: Icon(Icons.calendar_today,color: Colors.white,size: 25,)),

                                      title: Text('Week ${state.draftWeekPlans[index].weekNumber}',style: titilliumBoldRegular,),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('From :$formattedStartDate',style: titilliumRegular,),
                                              Text('To : ${formattedEndDate}',style: titilliumRegular,),
                                              Icon(Icons.arrow_forward_ios,color: Colors.black,size: 18,)
                                            ],
                                          ),
                                          // Text('Activities : ${weekData.length}',style: titilliumRegular,)
                                        ],
                                      ),
                                      onTap: (){

                                        CustomNavigation.push(context,
                                            MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (BuildContext context) {
                                                    return WeeklyPlanBloc(RealWeeklyPlanRepo());
                                                  },),
                                                BlocProvider(
                                                  create: (BuildContext context) {
                                                    return ConfirmWeekPlanBloc(RealConfirmWeekPlanRepo());
                                                  },),
                                                BlocProvider(
                                                  create: (BuildContext context) {
                                                    return ConstraintLogBloc(RealDeleteConstraintRepo());
                                                  },),
                                                BlocProvider(
                                                  create: (BuildContext context) {
                                                    return DeleteWeekActivityBloc(RealDeleteWeekActivityRepo());
                                                  },),

                                              ],
                                              child: DraftWeekPlanScreen(weekActivityId: state.draftWeekPlans[index].id, weekNumber:state.draftWeekPlans[index].weekNumber),
                                            )
                                        );
                                        // CustomNavigation.push(context,BlocProvider(
                                        //   create: (BuildContext context) {
                                        //     return DailyVarianceBloc(dailyVarianceDataRepo: RealDailyVarianceDataRepo());
                                        //   },
                                        //   child:  VarianceDaily(week_plan_id: state.userLocationPlans[index].id),
                                        // ),);
                                      },
                                    ),
                                    Divider()
                                  ],
                                );


                            },

                          ),
                        ),
                      ),
                    ],
                  );
                }
                else{
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(240, 240, 240, 1)
                    ),
                    child: Center(child: Text("No data available",style: titilliumSemiBold,)),
                  );
                }

              }
              else if(state is DraftWeekPlanError){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Color.fromRGBO(240, 240, 240, 1)
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(height:50,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.5,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(240, 240, 240, 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Image.asset("assets/images/no plan for day.jpg",fit: BoxFit.cover,),
                        ),
                        SizedBox(height: 10,),
                        Center(child: Text(state.message,style: titilliumBold,)),
                      ],
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
            }
        )

    );
  }

  Map<String, String> separateDateRange(String dateRange) {
    // Split the date range string into start date and end date
    List<String> dates = dateRange.split("_to_");
    String startDateString = dates[0];
    String endDateString = dates[1];

    // Parse the start and end dates
    List<String> startDateComponents = startDateString.split("-");
    List<String> endDateComponents = endDateString.split("-");

    // Extract day, month, and year components
    int startDay = int.parse(startDateComponents[0]);
    int startMonth = int.parse(startDateComponents[1]);
    int startYear = DateTime.now().year; // Assume current year if not specified
    int endDay = int.parse(endDateComponents[0]);
    int endMonth = int.parse(endDateComponents[1]);
    int endYear = DateTime.now().year; // Assume current year if not specified

    // Create DateTime objects
    DateTime startDate = DateTime(startYear, startMonth, startDay);
    DateTime endDate = DateTime(endYear, endMonth, endDay);

    // Format the start and end dates into the desired string format
    String formattedStartDate = "${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year.toString().substring(2)}";
    String formattedEndDate = "${endDate.day.toString().padLeft(2, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.year.toString().substring(2)}";

    // Return a map containing the formatted start and end dates
    return {
      'startDate': formattedStartDate,
      'endDate': formattedEndDate,
    };
  }
}
