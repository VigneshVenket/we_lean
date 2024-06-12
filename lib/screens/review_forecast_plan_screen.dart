import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/week_plan/week_plan_bloc.dart';
import 'package:we_lean/bloc/week_plan/week_plan_event.dart';
import 'package:we_lean/bloc/week_plan/week_plan_state.dart';
import 'package:we_lean/models/week_activity.dart';
import 'package:we_lean/screens/create_plan_screen.dart';
import 'package:we_lean/screens/daily_paln_screen.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/screens/profile_screen.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_button.dart';


class ReviewForecastPlanScreen extends StatefulWidget {

  List<WeekActivity>  ?weekActivity;

  ReviewForecastPlanScreen({Key? key,this.weekActivity}) : super(key: key);

  @override
  _ReviewForecastPlanScreenState createState() => _ReviewForecastPlanScreenState();
}

class _ReviewForecastPlanScreenState extends State<ReviewForecastPlanScreen> {



  Map<String, Map<String, List<WeekActivity>>> groupedActivities = {};
  @override
  void initState() {
    // TODO: implement initState
    List<WeekActivity> activities=widget.weekActivity!;

    for (var activity in activities) {
      // String formattedDate = DateFormat("dd-MM-yy").format(activity.weekDate!);
      groupedActivities.putIfAbsent(activity.weekDate!, () => {});
      groupedActivities[activity.weekDate]!.putIfAbsent(activity.day!, () => []);
      groupedActivities[activity.weekDate]![activity.day!]!.add(activity);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Save Forecast Plan",
      ),

      body:BlocListener<WeekPlanCreateBloc,WeekPlanCreateState>(
        listener: (context,state){
           if(state is WeekPlanCreateSuccessState){
             CustomMessenger.showMessage(context,state.weekPlanResponse.message!,Colors.green);
             CustomNavigation.pushAndRemoveUntill(context,MainScreen() );
           }
           else if(state is WeekPlanCreateErrorState){
             CustomMessenger.showMessage(context,state.error,Colors.red);
           }
        },
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: groupedActivities.length,
                itemBuilder: (context, index) {
                  var date = groupedActivities.keys.toList()[index];
                  var dayActivities = groupedActivities[date]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     '$date',
                      //     style: titilliumBoldRegular,
                      //   ),
                      // ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: dayActivities.length,
                        itemBuilder: (context, index) {
                          var day = dayActivities.keys.toList()[index];
                          var activities = dayActivities[day]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.04,
                                  decoration:BoxDecoration(
                                      color: CustomColors.themeColorOpac,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '$day',
                                          style: titilliumSemiBold.copyWith(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          '$date',
                                          style: titilliumSemiBold.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: activities.length,
                                itemBuilder: (context, index) {
                                  var activity = activities[index];
                                  return
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            children: [
                                              SizedBox(width: 15,),
                                              // Container(
                                              //     width: 60,
                                              //     height: 60,
                                              //     decoration: BoxDecoration(
                                              //       color: CustomColors.themeColorOpac,
                                              //       borderRadius: BorderRadius.circular(10)
                                              //     ),
                                              //     child: Icon(Icons.construction_sharp,color: Colors.white,size: 30,)),
                                              // SizedBox(width: 5,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.07,
                                                          height: MediaQuery.of(context).size.height*0.03,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: CustomColors.themeColorOpac
                                                          ),
                                                          child: Icon(Icons.location_pin,color: Colors.white,size: 18,)),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.23,
                                                          child: Text("Location ",style: titilliumRegular,)),
                                                      Text(": ${activity.category!}",style: titilliumBoldRegular,),
                                                    ],
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.07,
                                                          height: MediaQuery.of(context).size.height*0.03,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: CustomColors.themeColorOpac
                                                          ),
                                                          child: Icon(Icons.task,color: Colors.white,size: 18,)),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.23,
                                                          child: Text("Activity  ",style: titilliumRegular,)),
                                                      Text(": ${activity.activity!}",style: titilliumBoldRegular,),
                                                    ],
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.07,
                                                          height: MediaQuery.of(context).size.height*0.03,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: CustomColors.themeColorOpac
                                                          ),
                                                          child: Icon(Icons.queue,color: Colors.white,size: 18,)),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.23,
                                                          child: Text("Qty  ",style: titilliumRegular,)),
                                                      Text(": ${activity.plannedQty}${activity.uom}",style:titilliumBoldRegular,),
                                                    ],
                                                  ),
                                                  SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.07,
                                                          height: MediaQuery.of(context).size.height*0.03,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: CustomColors.themeColorOpac
                                                          ),
                                                          child: Icon(Icons.error,color: Colors.white,size: 18,)),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                          width:MediaQuery.of(context).size.width*0.23,
                                                          child: Text("Constraint ",style: titilliumRegular,)),
                                                      Text(": ${activity.constraint==null?"-":activity.constraint}",style:titilliumBoldRegular,),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      Divider()
                    ],
                  );
                },
              ),
            ),
            CustomButton(title: "Save Plan", onPressed: (){
              DateFormat format = DateFormat("yy-MM-dd");
              DateTime dateTime = format.parse(widget.weekActivity!.first.weekDate!);

              int weekNumber=_getWeekNumber(dateTime);
              String startdate=DateFormat("dd-MM-yy").format(_getStartDateOfWeek(weekNumber));
              String endDate=DateFormat("dd-MM-yy").format(_getEndDateOfWeek(weekNumber));


              // BlocProvider.of<WeekPlanCreateBloc>(context).add(
              //     PostWeekPlanCreateEvent(
              //         weekPlan: WeekPlan(
              //           userId: AppData.user!.id!,
              //           weekActivity: widget.weekActivity!
              //         ))
              // );


            }),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,)
          ],
        ),
      )
    );

  }



  int _getWeekNumber(DateTime date) {
    final yearStart = DateTime(date.year, DateTime.january, 1);
    final weekNumber = ((date.difference(yearStart).inDays) / 7).ceil();
    if (date.weekday == DateTime.sunday) {
      return weekNumber + 1;
    }
    return weekNumber;
  }

  DateTime _getStartDateOfWeek(int weekNumber) {
    final yearStart = DateTime(DateTime.now().year, DateTime.january, 1);
    final startDate = yearStart.add(Duration(days: (weekNumber - 1) * 7));
    return startDate.subtract(Duration(days: startDate.weekday - 1));
  }

  DateTime _getEndDateOfWeek(int weekNumber) {
    final yearStart = DateTime(DateTime.now().year, DateTime.january, 1);
    final endDate = yearStart.add(Duration(days: weekNumber * 7));
    return endDate.subtract(Duration(days: endDate.weekday));
  }
}
