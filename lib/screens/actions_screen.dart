import 'package:flutter/material.dart';
import 'package:we_lean/bloc/add_variancelog_action/add_variancelog_action_bloc.dart';
import 'package:we_lean/bloc/add_variancelog_action/add_variancelog_action_event.dart';
import 'package:we_lean/bloc/add_variancelog_action/add_variancelog_action_state.dart';
import 'package:we_lean/repo/add_action_repo.dart';
import 'package:we_lean/screens/actions_daily_screen.dart';
import 'package:we_lean/screens/home_screen.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../bloc/daily_variance_data/daily_variance_bloc.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_bloc.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_event.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_state.dart';
import '../repo/daily_variance_data_repo.dart';
import '../repo/line_chart_variance_data_repo.dart';
import '../utils/app_data.dart';
import '../utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class ActionsScreen extends StatefulWidget {

  final String varianceIds;
  final int week_plan_id;
  const ActionsScreen({required this.varianceIds,required this.week_plan_id,Key? key}) : super(key: key);

  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {

  TextEditingController _actionController=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<LineChartVarianceBloc>(context).add(FetchLineChartVarianceData(varianceId: widget.varianceIds));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Actions",
      ),
      body:
      BlocBuilder<LineChartVarianceBloc,LineChartVarianceState>(
        builder: (context,state){
          if(state is LineChartVarianceLoadedState){
            String formattedDate=convertDateFormat(state.lineChartVarianceresponse.data![0].weekActivity!.weekDate!);
            String formattedDay= getDayOfWeek(state.lineChartVarianceresponse.data![0].weekActivity!.weekDay!);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
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
                            formattedDay,
                            style: titilliumSemiBold.copyWith(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            formattedDate,
                            style: titilliumSemiBold.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.lineChartVarianceresponse.data!.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color.fromRGBO(
                                    219, 204, 204, 1.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                child: Icon(Icons.task_outlined,color: Colors.white,size: 18,)),
                                            SizedBox(width: 3,),
                                            Text("Activity",style:titilliumBoldRegular,),
                                          ],
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            height: MediaQuery.of(context).size.height*0.05,
                                            decoration: BoxDecoration(
                                                color: CustomColors.themeColorOpac,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text(state.lineChartVarianceresponse.data![index].weekActivity!.lineChartActivity!.name!,style: titilliumBoldRegular.copyWith(color: Colors.white),))
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                child: Icon(Icons.task_alt_sharp,color: Colors.white,size: 18,)),
                                            SizedBox(width: 3,),
                                            Text("Plan",style:titilliumBoldRegular,),
                                          ],
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            height: MediaQuery.of(context).size.height*0.05,
                                            decoration: BoxDecoration(
                                                color: CustomColors.themeColorOpac,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text(state.lineChartVarianceresponse.data![index].weekActivity!.plannedQty.toString(),style: titilliumBoldRegular.copyWith(color: Colors.white),))
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                child: Icon(Icons.task_alt_sharp,color: Colors.white,size: 18,)),
                                            SizedBox(width: 3,),
                                            Text("Actual",style:titilliumBoldRegular,),
                                          ],
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            height: MediaQuery.of(context).size.height*0.05,
                                            decoration: BoxDecoration(
                                                color: CustomColors.themeColorOpac,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(child: Text(state.lineChartVarianceresponse.data![index].weekActivity!.actualQty.toString(),style: titilliumBoldRegular.copyWith(color: Colors.white),))
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                child: Icon(Icons.contactless_outlined,color: Colors.white,size: 18,)),
                                            SizedBox(width: 3,),
                                            Text("Variance",style:titilliumBoldRegular,),
                                          ],
                                        ),
                                        Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            height: MediaQuery.of(context).size.height*0.08,
                                            decoration: BoxDecoration(
                                                color: CustomColors.themeColorOpac,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Center(child: Text(state.lineChartVarianceresponse.data![index].variance!.name!,style: titilliumBoldRegular.copyWith(color: Colors.white),)),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                child: Icon(Icons.grading,color: Colors.white,size: 18,)),
                                            SizedBox(width: 3,),
                                            Text("Actions",style:titilliumBoldRegular,),
                                          ],
                                         ),
                                            Container(
                                                 width: MediaQuery.of(context).size.width*0.6,
                                                 height: MediaQuery.of(context).size.height*0.08,
                                                 decoration: BoxDecoration(
                                                     border:Border.all(color: state.lineChartVarianceresponse.data![index].action==null?CustomColors.themeColor:Colors.white) ,
                                                     color: state.lineChartVarianceresponse.data![index].action==null?Colors.white:CustomColors.themeColorOpac,
                                                     borderRadius: BorderRadius.circular(10)
                                                 ),
                                                 child: Padding(
                                                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                   child: Center(child: Text(state.lineChartVarianceresponse.data![index].action==null?"Empty":state.lineChartVarianceresponse.data![index].action!,style: titilliumBoldRegular.copyWith(color: state.lineChartVarianceresponse.data![index].action==null?Colors.red:Colors.white),)),
                                                 )
                                            )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width*0.9,
                                      height: MediaQuery.of(context).size.height*0.05,
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
                                            _showActionUpdateDialog(context,state.lineChartVarianceresponse.data![index].id!);

                                          }, child:Text("Add Actions",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                                      )),
                                    ),
                                  ):Container(),
                                  AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? SizedBox(height: 10,):Container()
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
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

  void _showActionUpdateDialog(BuildContext context,int variancelogId){
    showDialog(
        context: context,
        builder: (context){
          return  BlocProvider.value(
            value: BlocProvider.of<AddVariancelogActionBloc>(context),
            child: BlocListener<AddVariancelogActionBloc,AddVarianceLogActionState>(
              listener: (context,state){
                if(state is AddVarianceLogActionSuccess){
                  Navigator.of(context).pop();
                  // CustomNavigation.pushReplacement(context,BlocProvider(
                  //   create: (BuildContext context) {
                  //     return DailyVarianceBloc(dailyVarianceDataRepo: RealDailyVarianceDataRepo());
                  //   },
                  //   child:  ActionsDailyScreen(week_plan_id: widget.week_plan_id),
                  // ),);
                  CustomNavigation.pushReplacement(context,  MultiBlocProvider(
                    providers: [

                      BlocProvider(
                        create: (BuildContext context) {
                          return LineChartVarianceBloc(RealLineChartVarianceDataRepo())
                            ..add(FetchLineChartVarianceData(varianceId: widget.varianceIds));
                        },),
                      BlocProvider(
                        create: (BuildContext context) {
                          return AddVariancelogActionBloc(addVarianceLogActionRepo: RealAddVarianceLogActionRepo());
                        },),
                    ],
                    child: ActionsScreen(varianceIds:widget.varianceIds,week_plan_id: widget.week_plan_id) ,
                  ),);
                  CustomMessenger.showMessage(context,"Action added successfully",Colors.green);
                }else if(state is AddVarianceLogActionFailure){
                  CustomMessenger.showMessage(context,state.errorMessage,Colors.green);
                }
              },
              child: AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.2,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 240, 240, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    controller: _actionController,
                    cursorColor:  CustomColors.themeColor,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      // fillColor:Color.fromRGBO(240, 240, 240, 1),
                      // filled: true,
                    ),
                  ),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.32,
                    height: MediaQuery.of(context).size.height*0.046,
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
                          _actionController.clear();
                          Navigator.of(context).pop();

                        }, child:Text("Cancel",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                    )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.32,
                    height: MediaQuery.of(context).size.height*0.046,
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
                          BlocProvider.of<AddVariancelogActionBloc>(context).add(PerformAddVarianceLogAction(variancelogid: variancelogId, actiondata: _actionController.text));
                          _actionController.clear();

                          Navigator.of(context).pop();
                          CustomNavigation.pushReplacement(context,  MultiBlocProvider(
                            providers: [

                              BlocProvider(
                                create: (BuildContext context) {
                                  return LineChartVarianceBloc(RealLineChartVarianceDataRepo())
                                    ..add(FetchLineChartVarianceData(varianceId: widget.varianceIds));
                                },),
                              BlocProvider(
                                create: (BuildContext context) {
                                  return AddVariancelogActionBloc(addVarianceLogActionRepo: RealAddVarianceLogActionRepo());
                                },),
                            ],
                            child: ActionsScreen(varianceIds:widget.varianceIds,week_plan_id: widget.week_plan_id) ,
                          ),);


                          // CustomMessenger.showMessage(context, "Action added successfully", Colors.green);
                        }, child:Text("Add",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                    )),
                  ),
                ],
              ),
            ),
          );


        });

  }
}

