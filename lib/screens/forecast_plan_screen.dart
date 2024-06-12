import 'package:flutter/material.dart';
import 'package:we_lean/bloc/approval_data/approval_bloc.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_bloc.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_event.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_state.dart';
import 'package:we_lean/repo/approval_data_repo.dart';
import 'package:we_lean/repo/user_location_plan_repo.dart';

import 'package:we_lean/screens/create_plan_screen.dart';
import 'package:we_lean/screens/forecast_plan_week_submit_screen.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import '../bloc/weekly_plan/weekly_plan_bloc.dart';
import '../models/user_location_plan.dart';
import '../repo/weekly_plan_repo.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar_main.dart';
import '../widgets/custom_route.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ForecastPlanScreen extends StatefulWidget {
  const ForecastPlanScreen({Key? key}) : super(key: key);

  @override
  _ForecastPlanScreenState createState() => _ForecastPlanScreenState();
}

class _ForecastPlanScreenState extends State<ForecastPlanScreen> {

  bool isApproved=false;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<UserLocationPlanBloc>(context).add(FetchUserLocationPlanEvent(AppData.user!.id!));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<UserLocationPlanBloc,UserLocationPlanState>(
          builder: (context,state){
             if(state is UserLocationPlanLoadedState){
                if(state.userLocationPlans.isNotEmpty){
                  return DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        // leading: IconButton(
                        //   onPressed: (){
                        //     Navigator.pop(context);
                        //   },
                        //   icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
                        // ),
                        title: Text(
                          "My Plans",
                          style: titilliumTitle.copyWith(color: Colors.black),
                        ),
                        bottom: TabBar(
                          unselectedLabelColor:Colors.black45,
                          unselectedLabelStyle: titilliumBoldRegular,
                          labelColor: CustomColors.themeColor,
                          labelStyle: titilliumBoldRegular,
                          indicatorColor:CustomColors.themeColor,
                          indicatorPadding: EdgeInsets.only(left: 8, right: 8),
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(text: 'Inprogress',),
                            Tab(text: 'Pending'),
                            Tab(text: 'Approved'),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          _buildPage(getPlansBy(state.userLocationPlans, "in_progress")),
                          _buildPage(getPlansBy(state.userLocationPlans, "pending")),
                          _buildPage(getPlansBy(state.userLocationPlans,"approved")),
                        ],
                      ),
                    ),
                  );
                }else{
                  return Scaffold(
                    appBar: CustomAppbar(title: "My Plans"),
                    body: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      // decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      // color: Color.fromRGBO(240, 240, 240, 1)
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
                            Center(child: Text("Create plan to view data in my plan screen ",style: titilliumBold,)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
             }else{
               return Center(
                 child: CircularProgressIndicator(
                   color: CustomColors.themeColor,
                 ),
               );
             }
          },
    )
      

    );
  }

  Widget _buildPage(List<UserLocationPlan> plansData){
    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: plansData.length,
                itemBuilder: (context,index){

                  Map<String, String> separatedDates = separateDateRange(plansData[index].dateRange);
                  String formattedStartDate = separatedDates['startDate']!;
                  String formattedEndDate = separatedDates['endDate']!;
                  return
                    Column(
                      children: [
                        Column(
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

                              title: Text('Week ${plansData[index].weekNumber}',style: titilliumBoldRegular,),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('From : $formattedStartDate',style: titilliumRegular,),
                                      Text('To : $formattedEndDate',style: titilliumRegular,),
                                      Icon(Icons.arrow_forward_ios,color: Colors.black,size: 18,)
                                    ],
                                  ),
                                  SizedBox(height: 5,),
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
                                            return ApprovalBloc(RealApprovalDataRepo());
                                          },),
                                      ],
                                      child: PlanSubmitScreen(weekActivityId: plansData[index].id, weekNumber: plansData[index].weekNumber),
                                    )
                                );

                              },
                            ),
                            Divider()
                          ],
                        ),

                      ],
                    );

                }),
          ),
        ),
      ],
    );
  }

  List<UserLocationPlan> getPlansBy(List<UserLocationPlan> plansData, String filterBy) {
    List<UserLocationPlan> tempPlans = [];

    for (int i = 0; i < plansData.length; i++) {
      if (plansData[i].approvalStatus == filterBy) {
        tempPlans.add(plansData[i]);
      }
    }
    return tempPlans;
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



