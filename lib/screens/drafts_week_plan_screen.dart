
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/confirm_week_plan/confirm_week_plan_bloc.dart';
import 'package:we_lean/bloc/confirm_week_plan/confirm_week_plan_event.dart';
import 'package:we_lean/bloc/confirm_week_plan/confirm_week_plan_state.dart';
import 'package:we_lean/bloc/delete_constraint/delete_constraint_bloc.dart';
import 'package:we_lean/bloc/delete_constraint/delete_constraint_event.dart';
import 'package:we_lean/bloc/delete_constraint/delete_constraint_state.dart';
import 'package:we_lean/bloc/delete_weekActivity/delete_weekactivity_bloc.dart';
import 'package:we_lean/bloc/delete_weekActivity/delete_weekactivity_event.dart';
import 'package:we_lean/bloc/delete_weekActivity/delete_weekactivity_state.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/utils/app_constants.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../bloc/weekly_plan/weekly_plan_bloc.dart';
import '../bloc/weekly_plan/weekly_plan_event.dart';
import 'package:intl/intl.dart';

import '../bloc/weekly_plan/weekly_plan_state.dart';
import '../repo/confirm_week_plan_repo.dart';
import '../repo/delete_constraint_repo.dart';
import '../repo/weekly_plan_repo.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar.dart';
import 'package:we_lean/models/weekly_plan.dart';

import '../widgets/custom_button_main.dart';


class DraftWeekPlanScreen extends StatefulWidget {

  final int weekActivityId;
  final int weekNumber;
  const DraftWeekPlanScreen({required this.weekActivityId,required this.weekNumber,Key? key}) : super(key: key);

  @override
  _DraftWeekPlanScreenState createState() => _DraftWeekPlanScreenState();
}

class _DraftWeekPlanScreenState extends State<DraftWeekPlanScreen> {
  int ?weekPlanId;

  @override
  void initState() {
    BlocProvider.of<ConstraintLogBloc>(context);
    BlocProvider.of<WeeklyPlanBloc>(context).add(FetchWeeklyPlan(widget.weekActivityId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: CustomAppbar(
          title: "Week ${widget.weekNumber}",
        ),

        body:MultiBlocListener(
          listeners: [
            BlocListener<ConfirmWeekPlanBloc,ConfirmWeekPlanState>(
              listener: (context,state){
                 if(state is ConfirmWeekPlanLoadedState){

                   CustomMessenger.showMessage(context, "Plan Created Successfuly", Colors.green);
                   CustomNavigation.pushAndRemoveUntill(context, MainScreen());
                 }else if(state is ConfirmWeekPlanErrorState){
                   CustomMessenger.showMessage(context, state.errorMessage, Colors.green);
                 }
              },
            ),
           BlocListener<DeleteWeekActivityBloc,DeleteWeekActivityState>(
             listener:(context,state){
               if(state is DeleteWeekActivityDeleted){
                 BlocProvider.of<WeeklyPlanBloc>(context).add(FetchWeeklyPlan(widget.weekActivityId));
                 CustomMessenger.showMessage(context, state.deleteWeekActivityResponse.message!, Colors.green);
               }else if( state is DeleteWeekActivityError){
                 CustomMessenger.showMessage(context, state.message, Colors.red);
               }

             } ,
           )
          ],
          child:BlocBuilder<WeeklyPlanBloc,WeeklyPlanState>(
            builder: (context,state){
              if( state is WeeklyPlanLoaded){
                 weekPlanId=state.weeklyPlanResponse.data!.weekplan.id;


                // Use a map to group week activities by date and day
                Map<String, List<WeekActivity>> groupedActivities = {};

                for (var activity in state.weeklyPlanResponse.data!.weekplan.weekActivities) {
                  String formattedDate = convertDateFormat(activity.weekDate);
                  String formattedDay = getDayOfWeek(activity.weekDay);
                  String key = '$formattedDate-$formattedDay';

                  if (!groupedActivities.containsKey(key)) {
                    groupedActivities[key] = [];
                  }

                  groupedActivities[key]!.add(activity);
                }
                return
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: groupedActivities.length,
                          itemBuilder: (context, index) {

                            String dateAndDay = groupedActivities.keys.elementAt(index);
                            List<String> dateParts = dateAndDay.split('-');

                            String formattedDate = dateParts[0]; // Extract the date part
                            String formattedMonth = dateParts[1]; // Extract the month part
                            String formattedYear = dateParts[2]; // Extract the year part

                            String fullDate = '$formattedDate-$formattedMonth-$formattedYear';
                            List<WeekActivity> activities = groupedActivities.values.elementAt(index);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.825,
                                        height: MediaQuery.of(context).size.height * 0.04,
                                        decoration: BoxDecoration(
                                          color: CustomColors.themeColorOpac,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text(
                                                dateAndDay.split('-').last,
                                                style: titilliumSemiBold.copyWith(color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10.0),
                                              child: Text(
                                                fullDate,
                                                style: titilliumSemiBold.copyWith(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.height * 0.04,
                                        height:MediaQuery.of(context).size.height * 0.04,
                                        decoration: BoxDecoration(
                                          color: CustomColors.themeColorOpac,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(child: IconButton(onPressed: (){
                                          BlocProvider.of<DeleteWeekActivityBloc>(context).add(DeleteWeekActivity(state.weeklyPlanResponse.data!.weekplan.weekActivities[index].id));
                                        }, icon:Icon(Icons.delete_outline,size: 16,color: Colors.white,))))
                                  ],
                                ),
                                ...activities.map((activity) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.93,
                                      height: MediaQuery.of(context).size.height * 0.17,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(220, 220, 220, 1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5),
                                            // Your activity details widget here
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.07,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: CustomColors.themeColorOpac,
                                                  ),
                                                  child: Icon(Icons.location_pin, color: Colors.white, size: 18),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                  child: Text("Work-Area", style: titilliumRegular),
                                                ),
                                                Text(": ${activity.category.name}", style: titilliumBoldRegular),
                                              ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.07,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: CustomColors.themeColorOpac,
                                                  ),
                                                  child: Icon(Icons.task, color: Colors.white, size: 18),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                  child: Text("Activity", style: titilliumRegular),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.54,
                                                  child: Text(": ${activity.activity.name}",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: titilliumBoldRegular),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.07,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: CustomColors.themeColorOpac,
                                                  ),
                                                  child: Icon(Icons.queue, color: Colors.white, size: 18),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                  child: Text("Quantity", style: titilliumRegular),
                                                ),
                                                Text(": ${activity.plannedQty}${activity.uom.name}", style: titilliumBoldRegular),
                                              ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                                            // Row(
                                            //   children: [
                                            //     Container(
                                            //       width: MediaQuery.of(context).size.width * 0.07,
                                            //       height: MediaQuery.of(context).size.height * 0.03,
                                            //       decoration: BoxDecoration(
                                            //         borderRadius: BorderRadius.circular(5),
                                            //         color: CustomColors.themeColorOpac,
                                            //       ),
                                            //       child: Icon(Icons.error, color: Colors.white, size: 18),
                                            //     ),
                                            //     SizedBox(width: 5),
                                            //     Container(
                                            //       width: MediaQuery.of(context).size.width * 0.25,
                                            //       child: Text("Constraints", style: titilliumRegular),
                                            //     ),
                                            //      activity.constraintLogs.isNotEmpty?
                                            //      Expanded(
                                            //       child: Container(
                                            //         width: MediaQuery.of(context).size.width * 0.45,
                                            //         height: MediaQuery.of(context).size.height * 0.03,
                                            //         child: ListView.builder(
                                            //           scrollDirection: Axis.horizontal,
                                            //           itemCount: activity.constraintLogs.length,
                                            //           itemBuilder: (context, index) {
                                            //             var constraint = activity.constraintLogs[index];
                                            //             var isFirstConstraint = index == 0;
                                            //             var isLastConstraint = index == activity.constraintLogs.length - 1;
                                            //             print(constraint.constraint.name+"- $index");
                                            //             return Center(
                                            //               child: Row(
                                            //                 children: [
                                            //                   if (isFirstConstraint) Text(": ", style: titilliumBoldRegular), // Add colon at the beginning
                                            //                   Text(constraint.constraint.name, style: titilliumBoldRegular),
                                            //                   if (!isLastConstraint) Text(", "), // Add comma unless it's the last constraint
                                            //                 ],
                                            //               ),
                                            //             );
                                            //           },
                                            //         ),
                                            //       ),
                                            //     ):Container(child: Row(
                                            //       children: [
                                            //         Text(": ", style: titilliumBoldRegular),
                                            //         Text("No constraint data",style: titilliumBoldRegular.copyWith(color: Colors.green),),
                                            //       ],
                                            //     ),)
                                            //   ],
                                            // ),
                                            BlocProvider(
                                              create:(BuildContext context) {
                                                return ConstraintLogBloc(RealDeleteConstraintRepo());
                                              },
                                              child: GestureDetector(
                                                onTap: (){
                                                  _showVarianceDialog(context,state.weeklyPlanResponse.data!.weekplan.weekActivities[index].constraintLogs);
                                                },
                                                child: Center(
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*0.5,
                                                    height: MediaQuery.of(context).size.height*0.04,
                                                    decoration: BoxDecoration(
                                                        color: CustomColors.themeColor,
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Center(child: Text("View Constraints",style: titilliumBoldRegular.copyWith(color: Colors.white),)),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                                  child: Divider(),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15,),

                      CustomButton(
                              title: "Create Plan",
                              onPressed: (){
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: Text('Confirm Plan',style: titilliumSemiBold,),
                                //       content: Text('Are you sure to create plan? If not, please review the plan once again and then confirm.',style: titilliumRegular,),
                                //       actions: <Widget>
                                //
                                //       [
                                //         Container(
                                //           height: MediaQuery.of(context).size.height*0.04,
                                //           width:MediaQuery.of(context).size.width*0.3,
                                //           child: CustomSubmitMain(title: "Cancel", onPressed:(){
                                //             Navigator.pop(context);
                                //           }
                                //           ),
                                //         ),
                                //         SizedBox(width: MediaQuery.of(context).size.width*0.11,),
                                //         Container(
                                //           height: MediaQuery.of(context).size.height*0.04,
                                //           width:MediaQuery.of(context).size.width*0.3,
                                //           child: CustomSubmitMain(title: "Confirm", onPressed:(){
                                //             BlocProvider.of<ConfirmWeekPlanBloc>(context).add(FetchConfirmWeekPlanEvent(weekPlanId: weekPlanId!));
                                //           }
                                //           ),
                                //         ),
                                //
                                //       ],
                                //     );
                                //   },
                                // );
                                BlocProvider.of<ConfirmWeekPlanBloc>(context).add(FetchConfirmWeekPlanEvent(weekPlanId: state.weeklyPlanResponse.data!.weekplan.id));
                              }
                              ),


                      SizedBox(height: 15,),
                    ],
                  );
              }

              else if(state is WeeklyPlanError){
                return Text(state.errorMessage);
              }else {
                return Center(child: CircularProgressIndicator(
                  color: CustomColors.themeColor,
                ));
              }
            },
          )
        )


    );

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

  void _showVarianceDialog(BuildContext context,List<ConstraintLog> constraintData){
    showDialog(
        context: context,
        builder: (context){
          return  BlocProvider.value(
               value: BlocProvider.of<ConstraintLogBloc>(context),
               child: BlocListener<ConstraintLogBloc,ConstraintLogState>(
                 listener: (context,state){
                   if(state is ConstraintLogDeleted){

                     CustomMessenger.showMessage(context,state.deleteConstraintLogResponse.message!, Colors.green);
                     // BlocProvider.of<WeeklyPlanBloc>(context).add(FetchWeeklyPlan(widget.weekActivityId));
                     Navigator.of(context).pop();
                     CustomNavigation.pushReplacement(context,
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

                           ],
                           child: DraftWeekPlanScreen(weekActivityId: widget.weekActivityId, weekNumber:widget.weekNumber),
                         )
                     );
                   }else if(state is ConstraintLogError){
                     CustomMessenger.showMessage(context, state.error, Colors.green);
                   }
                 },
                 child: AlertDialog(
                   title: Text("Constraints",style: titilliumBoldRegular,),
                   content: constraintData.isNotEmpty?
                   SingleChildScrollView(
                     child:
                     Container(
                         width: MediaQuery.of(context).size.width*0.9,
                         height: MediaQuery.of(context).size.height*0.2,
                         decoration: BoxDecoration(
                             color: Color.fromRGBO(240, 240, 240, 1),
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child:ListView.builder(
                             itemCount: constraintData.length,
                             itemBuilder: (context,index){
                               return Row(
                                 children: [
                                   SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                                   Container(
                                     width: MediaQuery.of(context).size.width * 0.07,
                                     height: MediaQuery.of(context).size.height * 0.03,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: CustomColors.themeColorOpac,
                                     ),
                                     child: Icon(Icons.error, color: Colors.white, size: 18),
                                   ),
                                   SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                                   Container(
                                       width: MediaQuery.of(context).size.width*0.4,
                                       child: Text(constraintData[index].constraint.name,style: titilliumRegular,)) ,

                                   IconButton(onPressed: (){
                                     BlocProvider.of<ConstraintLogBloc>(context).add(DeleteConstraintLog(constraintData[index].id));

                                   }, icon: Icon(Icons.delete_outline,color: CustomColors.themeColor,size: 20,))
                                 ],
                               );
                             })

                     ),
                   ):Container(
                     width: MediaQuery.of(context).size.width*0.9,
                     height: MediaQuery.of(context).size.height*0.2,
                     decoration: BoxDecoration(
                         color: Color.fromRGBO(240, 240, 240, 1),
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: Center(child: Text("No data available",style: titilliumRegular,)),
                   ),
                   actionsAlignment: MainAxisAlignment.spaceBetween,
                   actions: [
                     SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                     SizedBox(
                       width: MediaQuery.of(context).size.width*0.3,
                       height: MediaQuery.of(context).size.height*0.035,
                       child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                               elevation: 0,
                               backgroundColor: Colors.white,
                               side: BorderSide(
                                   color:CustomColors.themeColor
                               ),
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10)
                               )
                           ),
                           onPressed: (){
                             // _actionController.clear();
                             Navigator.of(context).pop();

                           }, child:Text("Cancel",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                       )),
                     ),
                     // SizedBox(
                     //   width: MediaQuery.of(context).size.width*0.36,
                     //   height: MediaQuery.of(context).size.height*0.046,
                     //   child: ElevatedButton(
                     //       style: ElevatedButton.styleFrom(
                     //           elevation: 0,
                     //           backgroundColor: Colors.white,
                     //           side: BorderSide(
                     //               color:CustomColors.themeColor
                     //           ),
                     //           shape: RoundedRectangleBorder(
                     //               borderRadius: BorderRadius.circular(10)
                     //           )
                     //       ),
                     //       onPressed: (){
                     //         // BlocProvider.of<AddVariancelogActionBloc>(context).add(PerformAddVarianceLogAction(variancelogid: variancelogId, actiondata: _actionController.text));
                     //         // _actionController.clear();
                     //         // CustomNavigation.pushAndRemoveUntill(context,BlocProvider(
                     //         //   create: (BuildContext context) {
                     //         //     return DailyVarianceBloc(dailyVarianceDataRepo: RealDailyVarianceDataRepo());
                     //         //   },
                     //         //   child:  ActionsDailyScreen(week_plan_id: widget.week_plan_id),
                     //         // ),);
                     //         // CustomMessenger.showMessage(context, "Action added successfully", Colors.green);
                     //       }, child:Text("Add",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                     //   )),
                     // ),
                   ],
                 ),
               )
          );


        });

  }
}
