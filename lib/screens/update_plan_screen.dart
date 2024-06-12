import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_lean/bloc/day_ppc/day_ppc_bloc.dart';
import 'package:we_lean/bloc/get_variance/get_variance_bloc.dart';
import 'package:we_lean/bloc/get_variance/get_variance_event.dart';
import 'package:we_lean/bloc/get_variance/get_variance_state.dart';
import 'package:we_lean/bloc/plan_update/plan_update_bloc.dart';
import 'package:we_lean/bloc/plan_update/plan_update_event.dart';
import 'package:we_lean/bloc/plan_update/plan_update_state.dart';
import 'package:we_lean/bloc/update_plan_screen_data/update_plan_screen_data_bloc.dart';
import 'package:we_lean/bloc/update_plan_screen_data/update_plan_screen_data_event.dart';
import 'package:we_lean/bloc/update_plan_screen_data/update_plan_screen_data_state.dart';
import 'package:we_lean/models/update_plan_data.dart';
import 'package:we_lean/models/update_plan_screen_data.dart';
import 'package:we_lean/repo/day_ppc_weekk_activity_repo.dart';
import 'package:we_lean/screens/ppc_summary.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button_main.dart';


class UpdatePlanScreen extends StatefulWidget {
  final int week_activity_id;
  
  const UpdatePlanScreen({required this.week_activity_id,Key? key}) : super(key: key);

  @override
  _UpdatePlanScreenState createState() => _UpdatePlanScreenState();
}

class _UpdatePlanScreenState extends State<UpdatePlanScreen> {

    List<String>  _status=["Y","N"];
    String? selectedStatus;
    String? selectedVariance;
    String ?_selectedActivity;
    String selectedQty=" ";
    String ?selectedVarianceKey;
    int? selectedWeekActivityId;
    String? selectedVariancegroup;
    String? selctedVariancegroupId;

    bool onVariancegroupSelected=false;

    TextEditingController ?_actualQtyController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<UpdatePlanScreenBloc>(context).add(FetchUpdatePlanScreenData(weekActivityId: widget.week_activity_id));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Update Plan",
      ),
      body:BlocListener<PlanUpdateBloc,PlanUpdateState>(
        listener: (context,state){
          if(state is PlanUpdateLoaded){
            onVariancegroupSelected=false;
            print(onVariancegroupSelected);
            BlocProvider.of<UpdatePlanScreenBloc>(context).add(FetchUpdatePlanScreenData(weekActivityId: widget.week_activity_id));
            CustomMessenger.showMessage(context,state.planUpdate.message!,Colors.green);
          }else if(state is PlanUpdateError){
            CustomMessenger.showMessage(context,state.errorMessage,Colors.red);
          }
        },
        child: BlocBuilder<UpdatePlanScreenBloc,UpdatePlanScreenState>(
          builder: (context,state){
            if(state is UpdatePlanScreenStateLoaded){
              return  SingleChildScrollView(
                child: Column(
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
                                getDayOfWeek(state.response.data!.updatedActivities.first.weekDay),
                                style: titilliumSemiBold.copyWith(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                convertDateFormat(state.response.data!.updatedActivities.first.weekDate),
                                style: titilliumSemiBold.copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            height: MediaQuery.of(context).size.height*0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color.fromRGBO(
                                  219, 204, 204, 1.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Activity",style:titilliumBoldRegular,),
                                      Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color.fromRGBO(240, 240, 240, 1),
                                          ),
                                          child:DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 2.0),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                padding: EdgeInsets.only(left: 12),
                                                dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                                value: _selectedActivity,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedActivity = newValue;
                                                    print('Selected Activity: $_selectedActivity');

                                                    var selectedActivityData = state.response.data!.updatedActivities.firstWhere(
                                                          (activity) => activity.activity.name == newValue,
                                                    );

                                                    selectedQty = selectedActivityData.plannedQty.toString();
                                                    selectedWeekActivityId = selectedActivityData.id;

                                                    if (selectedActivityData.actualQty != 0) {
                                                      CustomMessenger.showMessage(context, "Plan has already been updated", Colors.red);
                                                      _actualQtyController!.text = selectedActivityData.actualQty.toString();
                                                      int status = selectedActivityData.status;
                                                      print('Status: $status');
                                                      selectedStatus = status == 0 ? "N" : "Y";

                                                      if (status == 0) {
                                                        var firstVarianceLog = state.response.data!.updatedActivities.firstWhere(
                                                              (activity) => activity.activity.name == newValue,
                                                        ).varianceLogs.variance;
                                                        selctedVariancegroupId = firstVarianceLog.groupId;
                                                        print(firstVarianceLog.groupId);
                                                        print(selctedVariancegroupId!+"selected variance groipid");
                                                        selectedVariancegroup = firstVarianceLog.group.groupName;
                                                        onVariancegroupSelected = true;
                                                        BlocProvider.of<VariancesBloc>(context).add(FetchVariances(groupId: int.parse(selctedVariancegroupId!)));
                                                        selectedVarianceKey = firstVarianceLog.id.toString();
                                                        selectedVariance = firstVarianceLog.name;
                                                      }
                                                    }

                                                    print('Selected Week Activity ID: $selectedWeekActivityId');
                                                  });
                                                },
                                                items: state.response.data!.updatedActivities
                                                    .map((activity) => activity.activity.name)
                                                    .toSet() // Convert to a set to remove duplicates
                                                    .map((name) => DropdownMenuItem(
                                                  value: name,
                                                  child: Text(name, style: titilliumRegular),
                                                ))
                                                    .toList(),
                                              ),
                                            ),
                                          )


                                      ),

                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Plan Qty",style:titilliumBoldRegular,),
                                      Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color.fromRGBO(240, 240, 240, 1),
                                          ),
                                          child:Padding(
                                            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.width*0.028,left: MediaQuery.of(context).size.width*0.03),
                                            child: Text("${selectedQty}",style: titilliumRegular,),
                                          )
                                          // DropdownButtonHideUnderline(
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(right: 2.0),
                                          //     child: DropdownButton(
                                          //       isExpanded: true,
                                          //       padding: EdgeInsets.only(left: 12),
                                          //       dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                          //       value: selectedQty,
                                          //       onChanged: (newValue) {
                                          //         setState(() {
                                          //           selectedQty= newValue;
                                          //         });
                                          //       },
                                          //       items: state.response.data!.updatedActivities.map((activity) {
                                          //         return DropdownMenuItem(
                                          //           value: activity.plannedQty,
                                          //           child: Text('${activity.plannedQty}',style: titilliumRegular,),
                                          //         );
                                          //       }).toList(),
                                          //     ),
                                          //   ),
                                          // )

                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Actual Qty",style:titilliumBoldRegular,),
                                      Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(240, 240, 240, 1),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: PlanTextField(_actualQtyController!,
                                              (){
                                                if(int.parse(_actualQtyController!.text) < int.parse(selectedQty)){
                                                  setState(() {
                                                    selectedStatus='N';
                                                  });
                                                }
                                              }
                                          )

                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Status",style:titilliumBoldRegular,),
                                      Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(240, 240, 240, 1),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 2.0),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                padding: EdgeInsets.only(left: 17),
                                                value: selectedStatus,
                                                dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedStatus= newValue!;
                                                  });
                                                },
                                                items: _status.map((String status) {
                                                  return DropdownMenuItem(
                                                    value: status,
                                                    child: Text(status,style: titilliumRegular,),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: selectedStatus == 'N',
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Variance Type", style: titilliumBoldRegular,),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(240, 240, 240, 1),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 2.0),
                                                child: DropdownButton(
                                                  isExpanded: true,
                                                  padding: EdgeInsets.only(left: 17),
                                                  value: selectedVariancegroup,
                                                  dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectedVariancegroup = newValue!;
                                                      onVariancegroupSelected=true;
                                                      selectedVariance=null;
                                                    });

                                                    selctedVariancegroupId= state.response.data!.variances.entries.firstWhere(
                                                          (entry) => entry.value == newValue,
                                                    ).key;

                                                    BlocProvider.of<VariancesBloc>(context).add(FetchVariances(groupId: int.parse(selctedVariancegroupId!)));
                                                    print(selctedVariancegroupId);
                                                  },
                                                  items: state.response.data!.variances.entries.map((value) {
                                                    return DropdownMenuItem(
                                                      value: value.value,
                                                      child: Text(value.value, style: titilliumRegular,),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: onVariancegroupSelected && selectedStatus=="N",
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Variance", style: titilliumBoldRegular,),
                                        BlocBuilder<VariancesBloc,VariancesState>(
                                          builder: (context,state){
                                            if(state is VariancesLoaded){
                                              return Container(
                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                  height: MediaQuery.of(context).size.height * 0.05,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(240, 240, 240, 1),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 2.0),
                                                      child: DropdownButton(
                                                        isExpanded: true,
                                                        padding: EdgeInsets.only(left: 17),
                                                        value: selectedVariance,
                                                        dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedVariance = newValue!;

                                                          });

                                                          selectedVarianceKey= state.variancesResponse.data!.entries.firstWhere(
                                                                (entry) => entry.value == newValue,
                                                          ).key;
                                                          print(selectedVarianceKey);
                                                        },
                                                        items: state.variancesResponse.data!.entries.map((value) {
                                                          return DropdownMenuItem(
                                                            value: value.value,
                                                            child: Text(value.value, style: titilliumRegular,),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  )
                                              );
                                            }
                                            else if(state is VariancesInitial){
                                              return Container();
                                            }else if(state is VariancesError){
                                              return Text(state.message);
                                            }
                                            else{
                                              return CircularProgressIndicator(
                                                color: CustomColors.themeColor,
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: CustomSubmitMain(title: "Update", onPressed: (){
                        String ?selectedStatusValue;
                        selectedStatus=="Y"?selectedStatusValue="1":selectedStatusValue="0";
                        print(selectedStatusValue);

                        BlocProvider.of<PlanUpdateBloc>(context).add(UpdatePlanEvent(weekActivityId: selectedWeekActivityId!, updatePlanData: UpdatePlanData(
                          actualQty: _actualQtyController!.text,
                          status: selectedStatusValue,
                          varianceId: selectedVarianceKey==null?0:int.parse(selectedVarianceKey!)
                        )));

                        setState(() {
                          _selectedActivity=null;
                          selectedQty=" ";
                          selectedVariance=null;
                          _actualQtyController!.clear();
                          selectedStatus=null;
                          onVariancegroupSelected=false;
                        });

                      }),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: CustomSubmitMain(title: "View PPC",
                          onPressed: (){
                            CustomNavigation.push(context, BlocProvider(
                              create: (BuildContext context) {
                                return DayPpcBloc(dayPpcWeekActivityRepo: RealDayPpcWeekActivityRepo());
                              },
                              child: PPCSummaryScreen(week_activity_id: widget.week_activity_id,)
                            ),);
                          }),
                    )

                  ],
                ),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(
                  color: CustomColors.themeColor,
                ),
              );
            }
          },
        ) ,
      )


    );
  }

Widget PlanTextField(TextEditingController _controller,VoidCallback onSubmitted){
   return TextFormField(
     controller: _controller,
     cursorColor:  CustomColors.themeColor,
     style: titilliumRegular,
     keyboardType: TextInputType.number,
     decoration: InputDecoration(
         border: OutlineInputBorder(
           borderSide: const BorderSide(
             width: 0,
             style: BorderStyle.none,
           ),
         ),
         fillColor:Color.fromRGBO(240, 240, 240, 1),
         filled: true,
     ),
     onFieldSubmitted:(_){
       onSubmitted();
   },
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


class DailyPlanDetails{
  String ?activity;
  int ?plan;
  int ?actual;
  int ?variance;
  String ?status;

  DailyPlanDetails(this.activity,this.plan,this.actual,this.status,this.variance);


}

