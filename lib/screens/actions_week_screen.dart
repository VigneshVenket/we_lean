import 'package:flutter/material.dart';
import 'package:we_lean/screens/actions_daily_screen.dart';
import 'package:we_lean/screens/variance_daily.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../bloc/daily_variance_data/daily_variance_bloc.dart';
import '../bloc/user_location_plan/user_location_plan_bloc.dart';
import '../bloc/user_location_plan/user_location_plan_event.dart';
import '../bloc/user_location_plan/user_location_plan_state.dart';
import '../repo/daily_variance_data_repo.dart';
import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionWeekScreen extends StatefulWidget {
  const ActionWeekScreen({Key? key}) : super(key: key);

  @override
  _ActionWeekScreenState createState() => _ActionWeekScreenState();
}

class _ActionWeekScreenState extends State<ActionWeekScreen> {

  @override
  void initState() {
    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?BlocProvider.of<UserLocationPlanBloc>(context).add(FetchUserLocationPlanEvent(AppData.user!.id!)):
    BlocProvider.of<UserLocationPlanBloc>(context).add(FetchUserLocationPlanLocationwiseEvent(AppData.user!.id!,AppData.projectLocation!.id));
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
      AppBar(
        title: Text("Week Actions",style: titilliumTitle.copyWith(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
      ):AppData.user!.role_name=="Construction Manager"?
      AppBar(
        title: Text("Week Actions",style: titilliumTitle.copyWith(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
      ):CustomAppbarMain(title: "Week Actions"),
     body:
     BlocBuilder<UserLocationPlanBloc,UserLocationPlanState>(
         builder: (context,state){
           if(state is UserLocationPlanLoadedState){
             if(state.userLocationPlans.isNotEmpty){
               return  Column(
                 children: [
                   Expanded(
                     child: Container(
                       child: ListView.builder(
                         itemCount: state.userLocationPlans.length,
                         itemBuilder: (context,index){

                           Map<String, String> separatedDates = separateDateRange(state.userLocationPlans[index].dateRange);
                           String formattedStartDate = separatedDates['startDate']!;
                           String formattedEndDate = separatedDates['endDate']!;

                           if(state.userLocationPlans[index].approvalStatus=="approved"){
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
                                       child: Icon(Icons.grading,color: Colors.white,size: 25,)),

                                   title: Text('Week ${state.userLocationPlans[index].weekNumber}',style: titilliumBoldRegular,),
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
                                     CustomNavigation.push(context,BlocProvider(
                                       create: (BuildContext context) {
                                         return DailyVarianceBloc(dailyVarianceDataRepo: RealDailyVarianceDataRepo());
                                       },
                                       child:  ActionsDailyScreen(week_plan_id: state.userLocationPlans[index].id),
                                     ),);
                                   },
                                 ),
                                 Divider()
                               ],
                             );
                           }else{
                             return Container(
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
                                     Center(child: Text("No variance data available",style: titilliumBold,)),
                                   ],
                                 ),
                               ),
                             );
                           }

                         },

                       ),
                     ),
                   ),
                 ],
               );
             }else{
               return Container(
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
                       Center(child: Text("No actions data available",style: titilliumBold,)),
                     ],
                   ),
                 ),
               );
             }
           }else if(state is UserLocationPlanErrorState){
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
                     Center(child: Text(state.error,style: titilliumBold)),
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


class ActionsdataWeek{

  int? weekNo;
  String? from;
  String? to;

  ActionsdataWeek({this.weekNo,this.from,this.to});

}
