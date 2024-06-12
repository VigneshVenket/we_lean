import 'package:flutter/material.dart';

import '../widgets/custom_appbar_main.dart';
import '../widgets/custom_button.dart';

import 'package:intl/intl.dart';


class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  DateTime? fromDate;
  DateTime? toDate;
  List<PlannedActivity> plannedActivities = [];

  List<String> activities = ['Excavation', 'Foundation', 'Walls', 'Roofing'];
  String? selectedActivity;
  int? selectedQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarMain(
        title: "Create Plan",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ElevatedButton(
            //   onPressed: () async {
            //     final DateTime? pickedFrom = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime.now(),
            //       firstDate: DateTime.now().subtract(Duration(days: 7)),
            //       lastDate: DateTime.now().add(Duration(days: 7)),
            //     );
            //     final DateTime? pickedTo = await showDatePicker(
            //       context: context,
            //       initialDate: pickedFrom ?? DateTime.now(),
            //       firstDate: pickedFrom ?? DateTime.now(),
            //       lastDate: DateTime.now().add(Duration(days: 7)),
            //     );
            //     if (pickedFrom != null && pickedTo != null) {
            //       print(fromDate);
            //       print(toDate);
            //       setState(() {
            //         fromDate = pickedFrom;
            //         toDate = pickedTo;
            //       });
            //     }
            //   },
            //   child: Text(fromDate == null || toDate == null
            //       ? 'Select Week Dates'
            //       : 'Selected Dates: ${fromDate!} - ${toDate!}'),
            // ),
            CustomButton(
                title: fromDate == null || toDate == null
                    ? 'Select Week Dates'
                    : 'Selected Dates:  ${DateFormat('dd-MM-yyyy').format(fromDate!)} ~ ${DateFormat('dd-MM-yyyy').format(toDate!)}',
                onPressed:() async{
                  final DateTime? pickedFrom = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 7)),
                    lastDate: DateTime.now().add(Duration(days: 7)),
                  );
                  final DateTime? pickedTo = await showDatePicker(
                    context: context,
                    initialDate: pickedFrom ?? DateTime.now(),
                    firstDate: pickedFrom ?? DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 7)),
                  );
                  if (pickedFrom != null && pickedTo != null) {
                    print(fromDate);
                    print(toDate);
                    setState(() {
                      fromDate = pickedFrom;
                      toDate = pickedTo;
                    });
                  }
                }),
            SizedBox(height: 16.0),
            if (fromDate != null && toDate != null) ...[
              Text('Select Activities for the Week:'),
              DropdownButton<String>(
                value: selectedActivity,
                hint: Text('Select Activity'),
                onChanged: (value) {
                  setState(() {
                    selectedActivity = value;
                  });
                },
                items: activities.map((activity) {
                  return DropdownMenuItem<String>(
                    value: activity,
                    child: Text(activity),
                  );
                }).toList(),
              ),
              SizedBox(height: 8.0),
              DropdownButton<int>(
                value: selectedQuantity,
                hint: Text('Select Quantity'),
                onChanged: (value) {
                  setState(() {
                    selectedQuantity = value;
                  });
                },
                items: List.generate(10, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text((index + 1).toString()),
                  );
                }),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _addPlannedActivity();
                },
                child: Text('Add Activity'),
              ),
              SizedBox(height: 16.0),
              if (plannedActivities.isNotEmpty) ...[
                Text('Planned Activities:'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: plannedActivities.map((activity) {
                    return ListTile(
                      title: Text('Date: ${activity.date.toLocal()}'),
                      subtitle: Text('Activity: ${activity.activity}, Quantity: ${activity.quantity}'),
                    );
                  }).toList(),
                ),
              ],
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  _submitPlan();
                },
                child: Text('Submit Plan for Approval'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _addPlannedActivity() {
    if (selectedActivity != null && selectedQuantity != null && fromDate != null && toDate != null) {
      final DateTime date = fromDate!.add(Duration(days: plannedActivities.length));
      final PlannedActivity activity = PlannedActivity(date: date, activity: selectedActivity!, quantity: selectedQuantity!);
      setState(() {
        plannedActivities.add(activity);
      });
    }
  }

  void _submitPlan() {
    // Implement submission logic here
    if (plannedActivities.isNotEmpty) {
      // Submit the plan for manager approval
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Plan Submitted'),
            content: Text('Your plan for the week has been submitted for approval.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add activities to the plan.'),
        ),
      );
    }
  }
}


class PlannedActivity {
  final DateTime date;
  final String activity;
  final int quantity;

  PlannedActivity({required this.date, required this.activity, required this.quantity});
}