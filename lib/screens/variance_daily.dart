import 'package:flutter/material.dart';
import 'package:we_lean/bloc/daily_variance_data/daily_variance_bloc.dart';
import 'package:we_lean/bloc/daily_variance_data/daily_variance_event.dart';
import 'package:we_lean/bloc/daily_variance_data/daily_variance_state.dart';
import 'package:we_lean/screens/variance_screen.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_messenger.dart';

import '../bloc/line_chart_variance_data/line_chart_variance_data_bloc.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_event.dart';
import '../repo/line_chart_variance_data_repo.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class VarianceDaily extends StatefulWidget {
  final int week_plan_id;

  const VarianceDaily({required this.week_plan_id,Key? key}) : super(key: key);

  @override
  _VarianceDailyState createState() => _VarianceDailyState();
}

class _VarianceDailyState extends State<VarianceDaily> {

  List<VarianceData> varianceDataList=[
    VarianceData(
        day: "Mon",
        date: "01-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),
    VarianceData(
        day: "Tue",
        date: "02-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),
    VarianceData(
        day: "Wed",
        date: "03-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),
    VarianceData(
        day: "Thurs",
        date: "04-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),
    VarianceData(
        day: "Fri",
        date: "05-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),
    VarianceData(
        day: "Sat",
        date: "06-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),

    VarianceData(
        day: "Sun",
        date: "07-04-24",
        plan: 3,
        actual: 2,
        ppc: 95),
  ];

  @override
  void initState() {
    BlocProvider.of<DailyVarianceBloc>(context).add(FetchDailyVarianceData(week_plan_id: widget.week_plan_id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Daily Variance",
      ),
      body: BlocBuilder<DailyVarianceBloc,DailyVarianceState>(
          builder: (context,state){
            if(state is DailyVarianceLoaded){
              print(state.varianceData[0].date);
              return    Column(
                children: [
                  SizedBox(height: 10,),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.95,
                        child: ListView.builder(
                            itemCount:state.varianceData.length,
                            itemBuilder: (context,index){
                              String formattedDate=convertDateFormat(state.varianceData[index].date);
                              String formattedDay=getDayOfWeek(state.varianceData[index].day);
                              // print(state.varianceData[index].varianceLogIds.isNotEmpty);
                              String varianceIds=state.varianceData[index].varianceLogIds.join(',');

                              return Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.15,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Color.fromRGBO(
                                            219, 204, 204, 1.0)),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: CustomColors.themeColorOpac,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Icon(Icons.contactless_outlined,size: 24,color: Colors.white,),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.21,
                                          child: Column(
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 1,),
                                              Text(formattedDay,style: titilliumBoldRegular,),
                                              SizedBox(height: 10,),
                                              Text(formattedDate,style: titilliumBoldRegular,),
                                              SizedBox(height: 1,),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.575,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(height: 1),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                      width: MediaQuery.of(context).size.width*0.17,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(240, 240, 240, 1),
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text("Plan",style: titilliumBoldRegular,))),
                                                  Container(
                                                      width: MediaQuery.of(context).size.width*0.17,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(240, 240, 240, 1),
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text("Actual",style: titilliumBoldRegular,))),
                                                  Container(
                                                      width: MediaQuery.of(context).size.width*0.17,
                                                      decoration: BoxDecoration(
                                                          color: Color.fromRGBO(240, 240, 240, 1),
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text('PPC',style: titilliumBoldRegular,)))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                      width: MediaQuery.of(context).size.width*0.16,
                                                      height: MediaQuery.of(context).size.height*0.03,
                                                      decoration: BoxDecoration(
                                                          color:CustomColors.themeColorOpac,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: Center(child: Text(state.varianceData[index].planned.toString(),style: titilliumRegular.copyWith(color: Colors.white),))),
                                                  Container(
                                                      width: MediaQuery.of(context).size.width*0.16,
                                                      height: MediaQuery.of(context).size.height*0.03,
                                                      decoration: BoxDecoration(
                                                          color:CustomColors.themeColorOpac,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child:Center(child: Text(state.varianceData[index].actual.toString(),style:  titilliumRegular.copyWith(color: Colors.white)),)
                                                  ),
                                                  // Container(
                                                  //     width: MediaQuery.of(context).size.width*0.13,
                                                  //     height: MediaQuery.of(context).size.height*0.03,
                                                  //     decoration: BoxDecoration(
                                                  //         color:Colors.red,
                                                  //         borderRadius: BorderRadius.circular(5)
                                                  //     ),
                                                  //     child:Center(child: Text("1",style:  titilliumRegular.copyWith(color: Colors.white)),)
                                                  // ),
                                                  Container(
                                                      width: MediaQuery.of(context).size.width*0.16,
                                                      height: MediaQuery.of(context).size.height*0.03,
                                                      decoration: BoxDecoration(
                                                          color:CustomColors.themeColorOpac,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child:Center(child: Text(state.varianceData[index].ppc.toString()+"%",style: titilliumRegular.copyWith(color: Colors.white),),)
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width*0.58,
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
                                                      if(state.varianceData[index].varianceLogIds.isNotEmpty){
                                                        CustomNavigation.push(context,  BlocProvider(
                                                          create: (BuildContext context) {
                                                            return LineChartVarianceBloc(RealLineChartVarianceDataRepo())
                                                              ..add(FetchLineChartVarianceData(varianceId: varianceIds));
                                                          },
                                                          child:VarianceScreen(varianceIds:varianceIds) ,
                                                        ));
                                                      }else{
                                                        CustomMessenger.showMessage(context, "No variance data available", Colors.red);
                                                      }

                                                    }, child:Text("View Variance",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                                                )),
                                              ),
                                              SizedBox(height: 1),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,)
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
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


  String convertDateFormat(String originalDate) {
    // Parse the original date string
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(originalDate);

    // Format the date to the desired format
    String formattedDate = DateFormat('dd-MM-yy').format(parsedDate);

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


class VarianceData{

  String ?date;
  String ?day;
  int ?plan;
  int ?actual;
  int ?ppc;

  VarianceData({this.date,this.day,this.plan,this.actual,this.ppc});

}
