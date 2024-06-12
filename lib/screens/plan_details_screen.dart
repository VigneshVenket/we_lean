import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/models/weekly_plan.dart';
import 'package:we_lean/screens/plan_approval_screen.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../bloc/approval_data/approval_bloc.dart';
import '../bloc/approval_data/approval_event.dart';
import '../bloc/approval_data/approval_state.dart';
import '../bloc/user_location_plan/user_location_plan_bloc.dart';
import '../bloc/weekly_plan/weekly_plan_bloc.dart';
import '../bloc/weekly_plan/weekly_plan_event.dart';
import '../bloc/weekly_plan/weekly_plan_state.dart';
import '../repo/approval_data_repo.dart';
import '../repo/user_location_plan_repo.dart';
import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_messenger.dart';
import 'create_plan_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'main_screen.dart';

class PlanDetailsScreen extends StatefulWidget {
  final int weekActivityId;
  final String approvalStatus;
  const PlanDetailsScreen({required this.weekActivityId,required this.approvalStatus,Key? key}) : super(key: key);

  @override
  _PlanDetailsScreenState createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {


  @override
  void initState() {
    BlocProvider.of<WeeklyPlanBloc>(context).add(FetchWeeklyPlan(widget.weekActivityId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Plan Details",
      ),
        body: BlocListener<ApprovalBloc,ApprovalState>(
          listener: (context,state){
            if(state is ApprovalLoaded){
              // BlocProvider.of<UserLocationPlanBloc>(context).add(FetchUserLocationPlanEvent(AppData.user!.id!));
              CustomMessenger.showMessage(context, "Plan status changed successsfully", Colors.green);
              Navigator.of(context).pop();
              CustomNavigation.pushAndRemoveUntill(context, MainScreen());
              // CustomNavigation.push(context, MultiBlocProvider(
              //   providers: [
              //     BlocProvider(
              //       create: (BuildContext context){
              //         return UserLocationPlanBloc(RealUserLocationPlanRepo());
              //       },
              //     ),
              //     BlocProvider(
              //       create: (BuildContext context) {
              //         return ApprovalBloc(RealApprovalDataRepo());
              //       },),
              //
              //   ], child: PlanApprovalScreen(),
              // ));
              // CustomNavigation.pushReplacement(context, ProfileScreenManager());
            }else if(state is ApprovalError){
              CustomMessenger.showMessage(context, state.errorMessage, Colors.red);
            }
          },
          child: BlocBuilder<WeeklyPlanBloc, WeeklyPlanState>(
            builder: (context, state) {
              if (state is WeeklyPlanLoaded) {
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

                return Column(
                  children: [
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
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
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
                              ...activities.map((activity) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.93,
                                    height: MediaQuery.of(context).size.height * 0.148,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(240, 240, 240, 1),
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
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
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
                                                      style: titilliumBoldRegular)),
                                            ],
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
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
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.07,
                                                height: MediaQuery.of(context).size.height * 0.03,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: CustomColors.themeColorOpac,
                                                ),
                                                child: Icon(Icons.error, color: Colors.white, size: 18),
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.25,
                                                child: Text("Constraints", style: titilliumRegular),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.45,
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: activity.constraintLogs.length,
                                                    itemBuilder: (context, index) {
                                                      var constraint = activity.constraintLogs[index];
                                                      var isFirstConstraint = index == 0;
                                                      var isLastConstraint = index == activity.constraintLogs.length - 1;
                                                      if(activity.constraintLogs.isNotEmpty){
                                                        return Center(
                                                          child: Row(
                                                            children: [
                                                              if (isFirstConstraint) Text(": ", style: titilliumBoldRegular), // Add colon at the beginning
                                                              Text(constraint.constraint.name, style: titilliumBoldRegular),
                                                              if (!isLastConstraint) Text(","), // Add comma unless it's the last constraint
                                                            ],
                                                          ),
                                                        );
                                                      }else{
                                                        return Center(
                                                          child: Row(
                                                            children: [
                                                              if (isFirstConstraint) Text(": ", style: titilliumBoldRegular), // Add colon at the beginning
                                                              Text("No constarint added", style: titilliumBoldRegular),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
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
                    CustomButton(title: "Approve", onPressed: (){
                      if(widget.approvalStatus=='approved'){
                        // BlocProvider.of<ApprovalBloc>(context).add(SubmitApprovalEvent(weekPlanId:  widget.weekActivityId, userId: AppData.user!.id!, status: "approved"));
                        CustomMessenger.showMessage(context,"Plan has already been approved", Colors.red);
                      }else{
                        BlocProvider.of<ApprovalBloc>(context).add(SubmitApprovalEvent(weekPlanId:  widget.weekActivityId, userId: AppData.user!.id!, status: "approved"));
                      }
                    }),
                    SizedBox(height: 15,),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.themeColor,
                  ),
                );
              }
            },
          ),
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

}
