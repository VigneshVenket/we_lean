import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/daywise_ppc_list/daywise_ppc_list_event.dart';

import '../bloc/daywise_ppc_list/daywise_ppc_list_bloc.dart';
import '../bloc/daywise_ppc_list/daywise_ppc_list_state.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar.dart';
import 'package:intl/intl.dart';




class DaywisePPCListManagement extends StatefulWidget {
  String weekPlanIds;

  DaywisePPCListManagement({required this.weekPlanIds,Key? key}) : super(key: key);

  @override
  _DaywisePPCListManagementState createState() => _DaywisePPCListManagementState();
}

class _DaywisePPCListManagementState extends State<DaywisePPCListManagement> {


  List<String> days=["Mon","Tue","Wed","Thurs","Fri","Sat","Sun"];

  @override
  void initState() {
    BlocProvider.of<DayWisePPCBloc>(context).add(FetchDayWisePPCListManagement(weekPlanIds: widget.weekPlanIds));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: "Week PPC",
        ),
        body: BlocBuilder<DayWisePPCBloc,DayWisePPCState>(
          builder: (context,state){
            if(state is DayWisePPCLoaded){

              final countDatappc = state.dayWisePPCList.weekActivitiesPPC;
              print(countDatappc);
              final countList = countDatappc?.keys.map((dayData) => dayData).toList() ?? [];
              print(countList);

              final countListPlanned=countDatappc.values.map((e) => e.planned).toList()??[];
              final countListActual=countDatappc.values.map((e) => e.actual).toList()??[];
              final countListPPC=countDatappc.values.map((e) => e.ppc).toList()??[];

              return   Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color.fromRGBO(219, 204, 204, 1.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          children: [
                            DataContainer(0.2, 0.04, "Day", titilliumBoldRegular),
                            DataContainer(0.24, 0.04, "Date", titilliumBoldRegular),
                            DataContainer(0.18, 0.04, "Plan", titilliumBoldRegular),
                            DataContainer(0.2, 0.04,"Actual", titilliumBoldRegular),
                            DataContainer(0.1, 0.04, "PPC", titilliumBoldRegular)
                          ],
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: countList.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width:MediaQuery.of(context).size.width*0.17,
                                        height:MediaQuery.of(context).size.height*0.06,
                                        child: Text(days[index],style: titilliumRegular,)),
                                    Container(
                                        width:MediaQuery.of(context).size.width*0.3,
                                        height:MediaQuery.of(context).size.height*0.06,
                                        child: Text(convertDateFormat(countList[index]),style: titilliumRegular)),
                                    Container(
                                        width:MediaQuery.of(context).size.width*0.2,
                                        height:MediaQuery.of(context).size.height*0.06,
                                        child: Text("${countListPlanned[index]}",style: titilliumRegular)),
                                    Container(
                                        width:MediaQuery.of(context).size.width*0.16,
                                        height:MediaQuery.of(context).size.height*0.06,
                                        child: Text("${countListActual[index]}",style: titilliumRegular)),
                                    Container(
                                        width:MediaQuery.of(context).size.width*0.08,
                                        height:MediaQuery.of(context).size.height*0.06,
                                        child: Text("${countListPPC[index]}",style: titilliumRegular)),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
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
                              child: Center(child: Text("${state.dayWisePPCList.totalPPC.totalPlanned}",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                child: Center(child: Text("${state.dayWisePPCList.totalPPC.totalActual}",style: titilliumBoldRegular.copyWith(color: Colors.black),)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.05,
                          decoration: BoxDecoration(
                              color:CustomColors.themeColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width*0.17,),
                              Text("PPC",style:titilliumBoldRegular.copyWith(color: Colors.white)),
                              SizedBox(width: MediaQuery.of(context).size.width*0.42),
                              Text("${state.dayWisePPCList.totalPPC.totalPPC}%",style: titilliumBoldRegular.copyWith(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
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

  Widget DataContainer(double widthC,double heightC,String text,TextStyle styleC){
    return Container(
      width: MediaQuery.of(context).size.width*widthC,
      height: MediaQuery.of(context).size.height*heightC,
      child: Text(text,style:styleC),
    );
  }

  String convertDateFormat(String dateString) {
    // Parse the original date string
    final originalFormat = DateFormat('dd-MM-yyyy');
    final originalDate = originalFormat.parse(dateString);

    // Format the date with the new format
    final newFormat = DateFormat('dd-MM-yy');
    return newFormat.format(originalDate);
  }
}
