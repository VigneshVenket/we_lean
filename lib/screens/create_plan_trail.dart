import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';

import 'create_plan_screen.dart';


class CreatePlanTrail extends StatefulWidget {
  const CreatePlanTrail({Key? key}) : super(key: key);

  @override
  _CreatePlanTrailState createState() => _CreatePlanTrailState();
}

class _CreatePlanTrailState extends State<CreatePlanTrail> {

  // final List<int> constraintCountsPerDay = [2, 3, 1, 4, 2, 3, 5]; // Example data
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Constraint Bar Chart'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Container(
  //         height: MediaQuery.of(context).size.height*0.4,
  //         child: BarChart(
  //           BarChartData(
  //             alignment: BarChartAlignment.center,
  //             groupsSpace:25,
  //             titlesData: FlTitlesData(
  //               topTitles: SideTitles(
  //                 showTitles: true,
  //                 getTitles: (double value) {
  //                   // Customizing top titles to display the value of the y-axis from constraintCountsPerDay list
  //                   int index = value.toInt(); // Index of the constraintCountsPerDay list
  //                   if (index >= 0 && index < constraintCountsPerDay.length) {
  //                     return constraintCountsPerDay[index].toString();
  //                   }
  //                   return ''; // Return empty string if index is out of bounds
  //                 },
  //
  //               ),
  //               leftTitles: SideTitles(
  //                 showTitles: false,
  //                 // getTextStyles: (value) => TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
  //                 margin: 12,
  //                 reservedSize: 28,
  //                 interval: 1,
  //                 getTitles: (value) {
  //                   if (value == 0) {
  //                     return '0';
  //                   }
  //                   return value.toInt().toString();
  //                 },
  //               ),
  //               bottomTitles: SideTitles(
  //                 showTitles: true,
  //                 // getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
  //                 margin: 12,
  //                 getTitles: (double value) {
  //                   switch (value.toInt()) {
  //                     case 0:
  //                       return 'Mon';
  //                     case 1:
  //                       return 'Tue';
  //                     case 2:
  //                       return 'Wed';
  //                     case 3:
  //                       return 'Thu';
  //                     case 4:
  //                       return 'Fri';
  //                     case 5:
  //                       return 'Sat';
  //                     case 6:
  //                       return 'Sun';
  //                     default:
  //                       return '';
  //                   }
  //                 },
  //               ),
  //             ),
  //             borderData: FlBorderData(show: false),
  //             barGroups: List.generate(
  //               constraintCountsPerDay.length,
  //                   (index) => BarChartGroupData(
  //                     x: index,
  //                     barRods: [
  //                   BarChartRodData(
  //                     width: 20,
  //                     y: constraintCountsPerDay[index].toDouble(),
  //                     // colors: Colors.green,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  final List<int> constraintCountsPerDay = [2, 3, 1, 4, 2, 3, 5]; // Example data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Line Chart"),
      ),
      // body: Column(
      //   children: [
      //     SizedBox(height: 20,),
      //     Center(
      //       child: Container(
      //         width: MediaQuery.of(context).size.width*0.87,
      //         height: MediaQuery.of(context).size.height*0.4,
      //         child: LineChart(
      //           LineChartData(
      //             minX: 0,
      //             maxX: 6,
      //             minY: 0,
      //             maxY: 5,
      //             titlesData: FlTitlesData(
      //               bottomTitles: SideTitles(
      //                 showTitles: true,
      //                 getTextStyles: (context, value) => titilliumBoldRegular,
      //                 margin: 12,
      //                 getTitles: (double value) {
      //                   switch (value.toInt()) {
      //                     case 0:
      //                       return 'Mon';
      //                     case 1:
      //                       return 'Tue';
      //                     case 2:
      //                       return 'Wed';
      //                     case 3:
      //                       return 'Thu';
      //                     case 4:
      //                       return 'Fri';
      //                     case 5:
      //                       return 'Sat';
      //                     case 6:
      //                       return 'Sun';
      //                     default:
      //                       return '';
      //                   }
      //                 },
      //               ),
      //               leftTitles: SideTitles(
      //                 showTitles: false,
      //               ),
      //             ),
      //             borderData: FlBorderData(show: true, border: Border.all(color: CustomColors.themeColor, width: 2)),
      //             lineBarsData: [
      //               LineChartBarData(
      //                 spots: List.generate(
      //                   constraintCountsPerDay.length,
      //                       (index) => FlSpot(index.toDouble(), constraintCountsPerDay[index].toDouble()),
      //                 ),
      //                 isCurved: true,
      //                 colors: [CustomColors.themeColor],
      //                 barWidth: 4,
      //                 isStrokeCapRound: true,
      //                 belowBarData: BarAreaData(show: false),
      //                 dotData: FlDotData(
      //                   show: true,
      //                   getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
      //                     radius: 4,
      //                     color: Colors.red, // Change the dot color here
      //                     strokeWidth: 2,
      //                     strokeColor: Colors.red, // Change the border color here
      //                   ),
      //                 ),
      //               ),
      //             ],
      //               gridData: FlGridData(show: false),
      //             lineTouchData: LineTouchData(
      //               touchTooltipData: LineTouchTooltipData(
      //                 tooltipBgColor: Color.fromRGBO(240, 240, 240, 1)
      //               )
      //             )
      //
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

}
