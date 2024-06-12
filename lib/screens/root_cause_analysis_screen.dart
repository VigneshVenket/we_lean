import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/delete_rootcause/delete_rootcause_bloc.dart';
import 'package:we_lean/bloc/delete_rootcause/delete_rootcause_state.dart';
import 'package:we_lean/bloc/update_rootcause/update_rootcause_bloc.dart';
import 'package:we_lean/repo/update_root_cause_repo.dart';
import 'package:we_lean/screens/add_root_cause_data_screen.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import '../bloc/daily_variance_data/daily_variance_bloc.dart';
import '../bloc/daily_variance_data/daily_variance_event.dart';
import '../bloc/delete_rootcause/delete_rootcause_event.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_bloc.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_event.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_state.dart';
import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_route.dart';


class RootCauseAnalysisScreen extends StatefulWidget {
  final String varianceIds;
  final int week_plan_id;

  const RootCauseAnalysisScreen({required this.varianceIds,required this.week_plan_id,Key? key}) : super(key: key);

  @override
  _RootCauseAnalysisScreenState createState() => _RootCauseAnalysisScreenState();
}

class _RootCauseAnalysisScreenState extends State<RootCauseAnalysisScreen> {

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
        title: "Rootcause Analysis",
      ),
      body: BlocListener<RootCauseDeleteBloc,RootCauseDeleteState>(
        listener: (context,state){
           if(state is RootCauseDeleteSuccess){
             BlocProvider.of<LineChartVarianceBloc>(context).add(FetchLineChartVarianceData(varianceId: widget.varianceIds));
             CustomMessenger.showMessage(context,state.response.status!,Colors.green);
           }else if(state is RootCauseDeleteFailure){
             CustomMessenger.showMessage(context,state.error,Colors.red);
           }
        },
        child: BlocBuilder<LineChartVarianceBloc,LineChartVarianceState>(
          builder: (context,state){
            if(state is LineChartVarianceLoadedState){
              print(state.lineChartVarianceresponse.data![0].weekActivity!.weekDate!+"date");
              String formattedDate=convertDateFormat(state.lineChartVarianceresponse.data![0].weekActivity!.weekDate!);
              print(formattedDate+"format date");
              String formattedDay= getDayOfWeek(state.lineChartVarianceresponse.data![0].weekActivity!.weekDay!);

              // print(state.lineChartVarianceDataList[0].whyGroups);
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
                                height: MediaQuery.of(context).size.height*1.01,
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
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           Container(
                                    //               width:MediaQuery.of(context).size.width*0.07,
                                    //               height: MediaQuery.of(context).size.height*0.03,
                                    //               decoration: BoxDecoration(
                                    //                   borderRadius: BorderRadius.circular(5),
                                    //                   color: CustomColors.themeColorOpac
                                    //               ),
                                    //               child: Icon(Icons.grading,color: Colors.white,size: 18,)),
                                    //           SizedBox(width: 3,),
                                    //           Text("Actions",style:titilliumBoldRegular,),
                                    //         ],
                                    //       ),
                                    //       Container(
                                    //           width: MediaQuery.of(context).size.width*0.6,
                                    //           height: MediaQuery.of(context).size.height*0.08,
                                    //           decoration: BoxDecoration(
                                    //               border:Border.all(color: state.lineChartVarianceDataList[index].action==null?CustomColors.themeColor:Colors.white) ,
                                    //               color: state.lineChartVarianceDataList[index].action==null?Colors.white:CustomColors.themeColorOpac,
                                    //               borderRadius: BorderRadius.circular(10)
                                    //           ),
                                    //           child: Padding(
                                    //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    //             child: Center(child: Text(state.lineChartVarianceDataList[index].action==null?"Empty":state.lineChartVarianceDataList[index].action!,style: titilliumBoldRegular.copyWith(color: state.lineChartVarianceDataList[index].action==null?Colors.red:Colors.white),)),
                                    //           )
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(height: 10,),
                                    // AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    //   child: SizedBox(
                                    //     width: MediaQuery.of(context).size.width*0.9,
                                    //     height: MediaQuery.of(context).size.height*0.05,
                                    //     child: ElevatedButton(
                                    //         style: ElevatedButton.styleFrom(
                                    //             elevation: 0,
                                    //             backgroundColor: Colors.white,
                                    //             side: BorderSide(
                                    //                 color:CustomColors.themeColor
                                    //             ),
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius: BorderRadius.circular(10)
                                    //             )
                                    //         ),
                                    //         onPressed: (){
                                    //           // _showActionUpdateDialog(context,state.lineChartVarianceDataList[index].id!);
                                    //
                                    //         }, child:Text("Add Actions",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                                    //     )),
                                    //   ),
                                    // ):Container(),
                                    // AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? SizedBox(height: 10,):Container()
                                    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          CustomNavigation.push(context,  MultiBlocProvider(
                                              providers: [

                                                BlocProvider(
                                                  create: (BuildContext context) {
                                                    return RootCauseUpdateBloc(RealUpdateRootCauseRepo());

                                                  },),


                                              ],
                                              child: AddRootCauseDataScreen(varianceId: state.lineChartVarianceresponse.data![index].id!,varianceIds: widget.varianceIds,week_plan_id: widget.week_plan_id,rootCauseTagData: state.lineChartVarianceresponse.whyGroups!,)
                                          ),);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.9,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: CustomColors.themeColorOpac
                                          ),
                                          child: Center(child: Text("Add Rootcause",style: titilliumSemiBold.copyWith(color: Colors.white),)),
                                        ),
                                      ),
                                    ):
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: GestureDetector(

                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.9,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: CustomColors.themeColorOpac
                                          ),
                                          child: Center(child: Text("Rootcause",style: titilliumSemiBold.copyWith(color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Column(
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
                                                  child: Icon(Icons.question_mark_outlined,color: Colors.white,size: 18,)),
                                              SizedBox(width: 3,),
                                              Text("Why 1",style:titilliumBoldRegular),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                                              AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? GestureDetector(
                                                  onTap: (){
                                                    BlocProvider.of<RootCauseDeleteBloc>(context).add(DeleteRootCauseEvent(
                                                      state.lineChartVarianceresponse.data![index].id!,
                                                      "why1"
                                                    ));
                                                  },
                                                  child: Icon(Icons.delete_outline,size: 24,color: CustomColors.themeColor,)):Container()
                                              // IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,size: 24,color: CustomColors.themeColor,))

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.9,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(220, 220, 220, 1),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(child: Text(state.lineChartVarianceresponse.data![index].why1!=null?state.lineChartVarianceresponse.data![index].why1!:"No data available",style: titilliumBoldRegular,)),
                                              )
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Container(
                                                  width:MediaQuery.of(context).size.width*0.07,
                                                  height: MediaQuery.of(context).size.height*0.03,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: CustomColors.themeColorOpac
                                                  ),
                                                  child: Icon(Icons.question_mark_outlined,color: Colors.white,size: 18,)),
                                              SizedBox(width: 3,),
                                              Text("Why 2",style:titilliumBoldRegular),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                                              AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? GestureDetector(
                                                  onTap: (){
                                                    BlocProvider.of<RootCauseDeleteBloc>(context).add(DeleteRootCauseEvent(
                                                        state.lineChartVarianceresponse.data![index].id!,
                                                        "why2"
                                                    ));
                                                  },
                                                  child: Icon(Icons.delete_outline,size: 24,color: CustomColors.themeColor,)):Container()

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.9,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(220, 220, 220, 1),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(child: Text(state.lineChartVarianceresponse.data![index].why2!=null?state.lineChartVarianceresponse.data![index].why2!:"No data available",style: titilliumBoldRegular)),
                                              )
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Container(
                                                  width:MediaQuery.of(context).size.width*0.07,
                                                  height: MediaQuery.of(context).size.height*0.03,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: CustomColors.themeColorOpac
                                                  ),
                                                  child: Icon(Icons.question_mark_outlined,color: Colors.white,size: 18,)),
                                              SizedBox(width: 3,),
                                              Text("Why 3",style:titilliumBoldRegular),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                                              AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? GestureDetector(
                                                  onTap: (){
                                                    BlocProvider.of<RootCauseDeleteBloc>(context).add(DeleteRootCauseEvent(
                                                        state.lineChartVarianceresponse.data![index].id!,
                                                        "why3"
                                                    ));
                                                  },
                                                  child: Icon(Icons.delete_outline,size: 24,color: CustomColors.themeColor,)):Container()

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.9,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(220, 220, 220, 1),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(child: Text(state.lineChartVarianceresponse.data![index].why3!=null?state.lineChartVarianceresponse.data![index].why3!:"No data available",style: titilliumBoldRegular)),
                                              )
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Container(
                                                  width:MediaQuery.of(context).size.width*0.07,
                                                  height: MediaQuery.of(context).size.height*0.03,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: CustomColors.themeColorOpac
                                                  ),
                                                  child: Icon(Icons.question_mark_outlined,color: Colors.white,size: 18,)),
                                              SizedBox(width: 3,),
                                              Text("Why 4",style:titilliumBoldRegular),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                                              AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? GestureDetector(
                                                  onTap: (){
                                                    BlocProvider.of<RootCauseDeleteBloc>(context).add(DeleteRootCauseEvent(
                                                        state.lineChartVarianceresponse.data![index].id!,
                                                        "why4"
                                                    ));
                                                  },
                                                  child: Icon(Icons.delete_outline,size: 24,color: CustomColors.themeColor,)):Container()

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.9,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(220, 220, 220, 1),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(child: Text(state.lineChartVarianceresponse.data![index].why4!=null?state.lineChartVarianceresponse.data![index].why4!:"No data available",style: titilliumBoldRegular)),
                                              )
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Container(
                                                  width:MediaQuery.of(context).size.width*0.07,
                                                  height: MediaQuery.of(context).size.height*0.03,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: CustomColors.themeColorOpac
                                                  ),
                                                  child: Icon(Icons.question_mark_outlined,color: Colors.white,size: 18,)),
                                              SizedBox(width: 3,),
                                              Text("Why 5",style:titilliumBoldRegular),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.6,),
                                              AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"? GestureDetector(
                                                  onTap: (){
                                                    BlocProvider.of<RootCauseDeleteBloc>(context).add(DeleteRootCauseEvent(
                                                        state.lineChartVarianceresponse.data![index].id!,
                                                        "why5"
                                                    ));
                                                  },
                                                  child: Icon(Icons.delete_outline,size: 24,color: CustomColors.themeColor,)):Container()

                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.9,
                                              height: MediaQuery.of(context).size.height*0.08,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(220, 220, 220, 1),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Center(child: Text(state.lineChartVarianceresponse.data![index].why5!=null?state.lineChartVarianceresponse.data![index].why5!:"No data available",style: titilliumBoldRegular)),
                                              )
                                          )
                                        ],
                                      ),
                                    )
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
        ),
      ),
    );
  }


  // String convertDateFormat(String originalDate) {
  //   print(originalDate+"original date");
  //   // Parse the original date string
  //   DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(originalDate);
  //   print(parsedDate.toString()+"parsedDate");
  //   // Format the date to the desired format
  //   String formattedDate = DateFormat('dd-MM-yy').format(parsedDate);
  //
  //   return formattedDate;
  // }
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
