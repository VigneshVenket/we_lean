import 'package:flutter/material.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_state.dart';
import 'package:we_lean/repo/approval_data_repo.dart';
import 'package:we_lean/screens/plan_details_screen.dart';
import 'package:we_lean/screens/profile_screen_manager.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/approval_data/approval_bloc.dart';
import '../bloc/approval_data/approval_event.dart';
import '../bloc/approval_data/approval_state.dart';
import '../bloc/user_location_plan/user_location_plan_bloc.dart';
import '../bloc/user_location_plan/user_location_plan_event.dart';
import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../widgets/custom_appbar_main.dart';
import '../widgets/custom_messenger.dart';



class PlanApprovalScreen extends StatefulWidget {
  const PlanApprovalScreen({Key? key}) : super(key: key);

  @override
  _PlanApprovalScreenState createState() => _PlanApprovalScreenState();
}

class _PlanApprovalScreenState extends State<PlanApprovalScreen> {


  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<UserLocationPlanBloc>(context).add(FetchUserLocationPlanEvent(AppData.user!.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarMain(
        title: "Plan Approval",
      ),
    body: BlocListener<ApprovalBloc,ApprovalState>(
      listener: (context,state){
        if(state is ApprovalLoaded){
          BlocProvider.of<UserLocationPlanBloc>(context).add(FetchUserLocationPlanEvent(AppData.user!.id!));
          CustomMessenger.showMessage(context, "Plan status changed successsfully", Colors.green);
          // CustomNavigation.pushReplacement(context, ProfileScreenManager());
        }else if(state is ApprovalError){
          CustomMessenger.showMessage(context, state.errorMessage, Colors.red);
        }
      },
      child:  BlocBuilder<UserLocationPlanBloc,UserLocationPlanState>(
        builder: (context,state){
          if(state is UserLocationPlanLoadedState){
            if(state.userLocationPlans.isNotEmpty){
              return   Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                child: ListView.builder(
                    itemCount: state.userLocationPlans.length,
                    itemBuilder:(context,index){
                      if(state.userLocationPlans[index].approvalStatus=="pending"||state.userLocationPlans[index].approvalStatus=="approved"){
                        Map<String, String> separatedDates = separateDateRange(state.userLocationPlans[index].dateRange);
                        String formattedStartDate = separatedDates['startDate']!;
                        String formattedEndDate = separatedDates['endDate']!;
                        return GestureDetector(
                          onTap: (){

                            CustomNavigation.push(context,BlocProvider(
                              create: (BuildContext context) {
                                return ApprovalBloc(RealApprovalDataRepo());
                            },
                              child: PlanDetailsScreen(weekActivityId: state.userLocationPlans[index].id,approvalStatus: state.userLocationPlans[index].approvalStatus!),
                            ));},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              height: MediaQuery.of(context).size.height*0.1,
                              decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(240, 240, 240, 1)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  // Container(
                                  //     width: 48,
                                  //     height:48,
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //         color: CustomColors.themeColorOpac
                                  //     ),
                                  //     child: Icon(Icons.approval,color: Colors.white)),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.1,
                                            height: MediaQuery.of(context).size.height*0.05,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: CustomColors.themeColorOpac
                                            ),
                                            child: Icon(Icons.mail,color: Colors.white,size: 20,),
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Week : ${state.userLocationPlans[index].weekNumber}",style: titilliumBoldRegular,),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("From : ${formattedStartDate}",style: titilliumRegular,),
                                          SizedBox(width: 10,),
                                          Text("To : ${formattedEndDate}",style: titilliumRegular,)
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:state.userLocationPlans[index].approvalStatus=="pending"? Colors.red:Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                            )
                                        ),
                                        onPressed: (){
                                          // if(state.userLocationPlans[index].approvalStatus=="approved"){
                                          //   CustomMessenger.showMessage(context,"Plan is already approved", Colors.red);
                                          // }else{
                                          //   BlocProvider.of<ApprovalBloc>(context).add(SubmitApprovalEvent(weekPlanId:  state.userLocationPlans[index].id, userId: AppData.user!.id!, status: "approved"));
                                          // }


                                        }, child:Text(capitalizeFirstLetter(state.userLocationPlans[index].approvalStatus!),style: titilliumBoldRegular.copyWith(color: Colors.white)
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      else{
                        return Container();
                      }
                    }
                ),
              );
            }else{
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,

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
                      Center(child: Text("No plan data available",style: titilliumBold,)),
                    ],
                  ),
                ),
              );
            }

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

  String capitalizeFirstLetter(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}



