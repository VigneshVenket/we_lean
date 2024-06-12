import 'package:flutter/material.dart';
import 'package:we_lean/bloc/day_ppc/day_ppc_bloc.dart';
import 'package:we_lean/bloc/day_ppc/day_ppc_event.dart';
import 'package:we_lean/bloc/day_ppc/day_ppc_state.dart';
import 'package:we_lean/screens/update_plan_screen.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/day_ppc_week_activity.dart';
import '../utils/styles.dart';


class PPCSummaryScreen extends StatefulWidget {
  
  final int week_activity_id;
  
  const PPCSummaryScreen({required this.week_activity_id,Key? key}) : super(key: key);

  @override
  _PPCSummaryScreenState createState() => _PPCSummaryScreenState();
}

class _PPCSummaryScreenState extends State<PPCSummaryScreen> {

  int ?activitiesWithCountOne;
  double ?ppc;
  
  @override
  void initState() {
    BlocProvider.of<DayPpcBloc>(context).add(FetchDayPpcWeekActivities(weekActivityId: widget.week_activity_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Day PPC",
      ),
      body:BlocBuilder<DayPpcBloc,DayPpcState>(
        builder: (context,state){
          if(state is DayPpcLoaded){

            activitiesWithCountOne=countActivitiesWithStatusOne(state.weekActivities);
            ppc=calculatePpc( activitiesWithCountOne!,state.weekActivities.length)*100;
            print(ppc);

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color.fromRGBO(219, 204, 204, 1.0)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Activities",style: titilliumBoldRegular,),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.33,),
                                  Text("Plan",style: titilliumBoldRegular,),
                                  SizedBox(width: 30),
                                  Text("Actual",style: titilliumBoldRegular,),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.weekActivities.length,

                                itemBuilder:(context,index){



                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                            width:MediaQuery.of(context).size.width*0.53,
                                            child: Text(state.weekActivities[index].activity.name,style: titilliumRegular,)),
                                        Text("${state.weekActivities[index].plannedQty}",style: titilliumRegular),
                                        SizedBox(width: 50),
                                        Text("${state.weekActivities[index].actualQty}",style: titilliumRegular),
                                      ],
                                    ),
                                  );
                                }),
                          ) ,
                          Divider(),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Container(
                                      width:MediaQuery.of(context).size.width*0.5,
                                      child: Text("Activties Planned",style:titilliumRegular,)),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.38,
                                    height: MediaQuery.of(context).size.height*0.05,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(240, 240, 240, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(child: Text(state.weekActivities.length.toString(),style: titilliumBoldRegular,)),
                                  ),
                                  SizedBox(width: 3),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Container(
                                      width:MediaQuery.of(context).size.width*0.5,
                                      child: Text("Activities Achieved",style:titilliumRegular,)),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.38,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(240, 240, 240, 1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text(activitiesWithCountOne.toString(),style: titilliumBoldRegular)),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width*0.89,
                                height: MediaQuery.of(context).size.height*0.05,
                                decoration: BoxDecoration(
                                    color: CustomColors.themeColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width:MediaQuery.of(context).size.width*0.15,),
                                    Text("PPC",style:titilliumSemiBold.copyWith(color: Colors.white)),
                                    SizedBox(width:MediaQuery.of(context).size.width*0.43,),
                                    Text(ppc!.toInt().toString()+"%",style: titilliumSemiBold.copyWith(color: Colors.white),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ) ;
          }else{
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

  double calculatePpc(int planned,int achieved){
    return planned/achieved;
  }

  int countActivitiesWithStatusOne(List<DayPpcWeekActivity> weekActivities) {
    int count = 0;
    for (var activity in weekActivities) {
      if (activity.status == 1) {
        count++;
      }
    }
    return count;
  }

}
