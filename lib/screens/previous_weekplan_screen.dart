
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/current_week_plan/current_week_plan_bloc.dart';
import '../bloc/current_week_plan/current_week_plan_event.dart';
import '../bloc/current_week_plan/current_week_plan_state.dart';
import '../models/current_week_plan_activity.dart';
import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../utils/shared_pref_service.dart';
import 'package:intl/intl.dart';

import '../utils/styles.dart';
import 'daily_paln_screen.dart';


class PreviousWeekPlanScreen extends StatefulWidget {
  const PreviousWeekPlanScreen({Key? key}) : super(key: key);

  @override
  _PreviousWeekPlanScreenState createState() => _PreviousWeekPlanScreenState();
}

class _PreviousWeekPlanScreenState extends State<PreviousWeekPlanScreen> {


  String? _startWeek;
  int _weeknumber=0;
  int _currentweekUpdate=0;


  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<CurrentWeekPlanBloc>(context).add(FetchPreviousWeekPlanEvent(userId: AppData.user!.id!));

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
        _currentweekUpdate =_weeknumber - int.parse(_startWeek!);
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
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
          ),
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
                      Center(child: Text("No plan found for the week",style: titilliumSemiBold,)),
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
