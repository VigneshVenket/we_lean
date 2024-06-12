import 'package:flutter/material.dart';
import 'package:we_lean/bloc/current_week_plan/current_week_plan_bloc.dart';
import 'package:we_lean/bloc/current_week_plan/current_week_plan_event.dart';
import 'package:we_lean/bloc/current_week_plan/current_week_plan_state.dart';
import 'package:we_lean/bloc/get_variance/get_variance_bloc.dart';
import 'package:we_lean/bloc/plan_update/plan_update_bloc.dart';
import 'package:we_lean/bloc/update_plan_screen_data/update_plan_screen_data_bloc.dart';
import 'package:we_lean/models/current_week_plan_activity.dart';
import 'package:we_lean/repo/current_week_plan_activity_repo.dart';
import 'package:we_lean/repo/get_variance_repo.dart';
import 'package:we_lean/repo/plan_update_repo.dart';
import 'package:we_lean/repo/update_plan_screen_data_repo.dart';
import 'package:we_lean/screens/create_plan_screen.dart';
import 'package:we_lean/screens/plan_details_screen.dart';
import 'package:we_lean/screens/previous_weekplan_screen.dart';
import 'package:we_lean/screens/update_plan_screen.dart';
import 'package:we_lean/screens/view_plan_screen.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/posts/post_bloc.dart';
import '../repo/posts_repo.dart';
import '../utils/colors.dart';
import '../utils/shared_pref_service.dart';
import '../utils/styles.dart';
import 'add_post_screen.dart';

class DailyPlanScreen extends StatefulWidget {
  const DailyPlanScreen({Key? key}) : super(key: key);

  @override
  _DailyPlanScreenState createState() => _DailyPlanScreenState();
}

class _DailyPlanScreenState extends State<DailyPlanScreen> {
  String? _startWeek;
  int _weeknumber=0;
  int _currentweekUpdate=0;


  @override
  void initState() {
    // TODO: implement initState
    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?
    BlocProvider.of<CurrentWeekPlanBloc>(context).add(FetchCurrentWeekPlanEvent(userId: AppData.user!.id!)):
    BlocProvider.of<CurrentWeekPlanBloc>(context).add(FetchCurrentWeekPlanLocationwiseEvent(userId: AppData.user!.id!, proj_loc_id: AppData.projectLocation!.id));
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final sharedPreferencesService = await SharedPreferencesService.instance;
    final String? retrievedStartWeek = sharedPreferencesService.startWeek;
    setState(() {
      _startWeek = retrievedStartWeek;
      _weeknumber = getWeekOfYear(DateTime.now());
      // Calculate current week based on start week
      if (_startWeek != null) {
        _currentweekUpdate =_weeknumber - int.parse(_startWeek!) + 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppbarMain(
      //   title: "Week Plan - $_currentweekUpdate",
      // ),
        appBar: AppBar(
          title: Text("Week Plan - $_currentweekUpdate",style: titilliumTitle.copyWith(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
            Padding(
                padding: const EdgeInsets.all(10.0),
                child:GestureDetector(
                    onTap: (){CustomNavigation.push(context,  BlocProvider(
                      create: (BuildContext context) {
                        return CurrentWeekPlanBloc(RealCurrentWeekPlanRepo())
                            ..add(FetchPreviousWeekPlanEvent(userId: AppData.user!.id!));
                      },
                      child:PreviousWeekPlanScreen(),
                    ),);},
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.27,
                    height: MediaQuery.of(context).size.height*0.03,
                    decoration: BoxDecoration(
                      color: CustomColors.themeColor,
                      borderRadius: BorderRadius.circular(10)
                    ),child: Center(child: Text("Previous",style: titilliumBoldRegular.copyWith(color: Colors.white),)),
                  ),
                    // child: Icon(Icons.arrow_forward_ios,color: Colors.black,size: 18,)

                )
            ):Container()
          ],
        ),
      body: BlocBuilder<CurrentWeekPlanBloc,CurrentWeekPlanState>(
        builder: (context,state){
          if(state is CurrentWeekPlanStateLoaded){
            if (state.currentWeekPlanResponse.data != null) {
              print(state.currentWeekPlanResponse.data!.values.toList()[0]);

              List<WeekActivity> dataList = state.currentWeekPlanResponse.data!.values.expand((x) => x).toList();
              dataList.sort((a, b) => a.weekDay.compareTo(b.weekDay));

              // Group activities by weekDay
              Map<int, List<WeekActivity>> activitiesByDay = {};
              for (var activity in dataList) {
                activitiesByDay.putIfAbsent(activity.weekDay, () => []).add(activity);
              }

              return Column(
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: ListView.builder(
                          itemCount: activitiesByDay.length,
                          itemBuilder: (context, index) {
                            int weekDay = activitiesByDay.keys.elementAt(index);
                            List<WeekActivity> activities = activitiesByDay[weekDay]!;
                            String formattedDate = convertDateFormat(activities[0].weekDate);
                            String formattedDay = getDayOfWeek(activities[0].weekDay);

                            int activitiesCount = activities.length;
                            int activitiesWithStatusOneCount = activities.where((activity) => activity.status == 1).length;
                            bool hasStatusZero = activities.any((activity) => activity.status == 0);
                            String dayStatus = hasStatusZero ? 'N' : 'Y';

                            return Column(
                              children: [
                                DayHeader(
                                  formattedDay: formattedDay,
                                  formattedDate: formattedDate,
                                  activitiesCount: activitiesCount,
                                  activitiesWithStatusOneCount: activitiesWithStatusOneCount,
                                  dayStatus: dayStatus,
                                  weekActivityId:activities[0].id,

                                ),
                                // ...activities.map((activity) => ActivityDetail(activity: activity)).toList(),
                                SizedBox(height: 5),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }else{
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(240, 240, 240, 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text("No plan data available for this location",style: titilliumSemiBold,)),
                ),
              );
            }
          }else if(state is CurrentWeekPlanStateError){
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
                    Center(child: Text("No plan found for current week",style: titilliumSemiBold,)),
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
        },
      )


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

  String convertDateFormat(String originalDate) {

    DateTime dateTime = DateTime.parse(originalDate);
    String formattedDate = DateFormat('dd-MM-yy').format(dateTime);
    return formattedDate;

  }

  String getDayOfWeek(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Invalid day number';
    }
  }

}


class DayHeader extends StatelessWidget {
  final String formattedDay;
  final String formattedDate;
  final int activitiesCount;
  final int activitiesWithStatusOneCount;
  final String dayStatus;
  final int weekActivityId;

  DayHeader({
    required this.formattedDay,
    required this.formattedDate,
    required this.activitiesCount,
    required this.activitiesWithStatusOneCount,
    required this.dayStatus,
    required this.weekActivityId
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppData.user!.role_name == "Site Engineer" || AppData.user!.role_name == "Planning Engineer"
          ? MediaQuery.of(context).size.height * 0.15
          : MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(219, 204, 204, 1.0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 5),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: CustomColors.themeColorOpac,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.construction_outlined, size: 24, color: Colors.white),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.21,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 1),
                Text(formattedDay, style: titilliumBoldRegular),
                SizedBox(height: 10),
                Text(formattedDate, style: titilliumBoldRegular),
                SizedBox(height: 1),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.575,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoContainer(context, "Plan"),
                    _buildInfoContainer(context, "Actual"),
                    _buildInfoContainer(context, "Status"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDataContainer(context, activitiesCount.toString()),
                    _buildDataContainer(context, activitiesWithStatusOneCount.toString()),
                    _buildDataContainer(context, dayStatus),
                  ],
                ),
                AppData.user!.role_name == "Site Engineer" || AppData.user!.role_name == "Planning Engineer"?
                    Column(
                      children: [
                        SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.58,
                          height: MediaQuery.of(context).size.height * 0.046,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              side: BorderSide(color: CustomColors.themeColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              CustomNavigation.push(
                                context,
                                MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (BuildContext context) {
                                        return UpdatePlanScreenBloc(
                                          updatePlanScreenRepo: RealUpdatePlanScreenRepo(),
                                        );
                                      },
                                    ),
                                    BlocProvider(
                                      create: (BuildContext context) {
                                        return PlanUpdateBloc(RealPlanUpdateRepo());
                                      },
                                    ),
                                    BlocProvider(
                                      create: (BuildContext context) {
                                        return VariancesBloc(RealGetVarianceRepo());
                                      },
                                    ),
                                  ],
                                  child: UpdatePlanScreen(week_activity_id: weekActivityId),
                                ),
                              );
                            },
                            child: Text("Update", style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)),
                          ),
                        ),
                        SizedBox(height: 1)
                      ],
                    ):SizedBox(height: 2,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildInfoContainer(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.17,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(text, style: titilliumBoldRegular)),
    );
  }

  Container _buildDataContainer(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.16,
      height: MediaQuery.of(context).size.height * 0.03,
      decoration: BoxDecoration(
        color: CustomColors.themeColorOpac,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: Text(text, style: titilliumRegular.copyWith(color: Colors.white))),
    );
  }
}
