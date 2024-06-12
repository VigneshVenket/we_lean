import 'package:flutter/material.dart';
import 'package:we_lean/bloc/line_chart_variance_data/line_chart_variance_data_bloc.dart';
import 'package:we_lean/bloc/line_chart_variance_data/line_chart_variance_data_event.dart';
import 'package:we_lean/bloc/line_chart_variance_data/line_chart_variance_data_state.dart';
import 'package:intl/intl.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VarianceScreen extends StatefulWidget {
  final String varianceIds;

  const VarianceScreen({required this.varianceIds,Key? key}) : super(key: key);

  @override
  _VarianceScreenState createState() => _VarianceScreenState();
}

class _VarianceScreenState extends State<VarianceScreen> {

  List<VarianceDailyData>  _varianceDailydataList=[
    VarianceDailyData(
        Activity: "Excavation",
        plan: 2,
        actual: 1,
        variance: "Manpower",
    ),
    VarianceDailyData(
        Activity: "Electrical Wiring",
        plan: 2,
        actual: 1,
        variance: "Material Supply",
    )
  ];

  @override
  void initState() {
    BlocProvider.of<LineChartVarianceBloc>(context).add(FetchLineChartVarianceData(varianceId: widget.varianceIds));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Variance",
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
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Center(child: Text(state.lineChartVarianceresponse.data![index].variance!.name!,style: titilliumBoldRegular.copyWith(color: Colors.white),)),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
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
}


class VarianceDailyData{

  String? Activity;
  int? plan;
  int? actual;
  String? variance;

  VarianceDailyData({
    this.Activity,
    this.plan,
    this.actual,
    this.variance,
  });

}
