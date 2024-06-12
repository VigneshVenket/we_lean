import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/screens/review_forecast_plan_screen.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:intl/intl.dart';

import 'create_plan_screen.dart';

class SaveForeCastPlanScreeen extends StatefulWidget {
  final List<ActivitiesDataPlan> activitiesData;

  SaveForeCastPlanScreeen({required this.activitiesData,Key? key}) : super(key: key);

  @override
  _SaveForeCastPlanScreeenState createState() => _SaveForeCastPlanScreeenState();
}

class _SaveForeCastPlanScreeenState extends State<SaveForeCastPlanScreeen> {
  @override
  Widget build(BuildContext context) {

    List<int> weekNumbers = [];
    for (int i = 0; i < widget.activitiesData.length; i++) {
      final date = widget.activitiesData[i].date!;
      final weekNumber = _getWeekNumber(date);
      if (!weekNumbers.contains(weekNumber)) {
        weekNumbers.add(weekNumber);
      }
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: "Review Forecast Plan",
      ),
      body:
      Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: weekNumbers.length,
                  itemBuilder: (context,index){
                    final weekNumber = weekNumbers[index];
                    final fromDate = _getStartDateOfWeek(weekNumber);
                    final toDate = _getEndDateOfWeek(weekNumber);
                    String formattedDateFrom = DateFormat("dd-MM-yy").format(fromDate);
                    String formattedDateTo = DateFormat("dd-MM-yy").format(toDate);

                    final weekData = widget.activitiesData.where((data) {
                      final date = data.date!;
                      final dataWeekNumber = _getWeekNumber(date);
                      return dataWeekNumber == weekNumber;
                    }).toList();
                    return
                      Column(
                      children: [
                        Column(
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
                                    child: Icon(Icons.calendar_today,color: Colors.white,size: 25,)),
                                // onTap: (){CustomNavigation.push(context, ReviewForecastPlanScreen(activitiesData: weekData));},
                                title: Text('Week $weekNumber',style: titilliumBoldRegular,),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('From : $formattedDateFrom',style: titilliumRegular,),
                                        Text('To : $formattedDateTo',style: titilliumRegular,),
                                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 18,)
                                      ],
                                    ),
                                    // Text('Activities : ${weekData.length}',style: titilliumRegular,)
                                  ],
                                )
                            ),
                            Divider()
                          ],
                        ),

                      ],
                    );

              }),
            ),
          ),
        ],
      ),
    );
  }

  int _getWeekNumber(DateTime date) {
    final yearStart = DateTime(date.year, DateTime.january, 1);
    final weekNumber = ((date.difference(yearStart).inDays) / 7).ceil();
    if (date.weekday == DateTime.sunday) {
      return weekNumber + 1;
    }
    return weekNumber;
  }

  DateTime _getStartDateOfWeek(int weekNumber) {
    final yearStart = DateTime(DateTime.now().year, DateTime.january, 1);
    final startDate = yearStart.add(Duration(days: (weekNumber - 1) * 7));
    return startDate.subtract(Duration(days: startDate.weekday - 1));
  }

  DateTime _getEndDateOfWeek(int weekNumber) {
    final yearStart = DateTime(DateTime.now().year, DateTime.january, 1);
    final endDate = yearStart.add(Duration(days: weekNumber * 7));
    return endDate.subtract(Duration(days: endDate.weekday));
  }
}

