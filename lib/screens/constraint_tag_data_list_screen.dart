import 'package:flutter/material.dart';
import 'package:we_lean/widgets/custom_appbar.dart';



class ConstraintTagDataListScreen extends StatefulWidget {
  const ConstraintTagDataListScreen({Key? key}) : super(key: key);

  @override
  _ConstraintTagDataListScreenState createState() => _ConstraintTagDataListScreenState();
}

class _ConstraintTagDataListScreenState extends State<ConstraintTagDataListScreen> {

  final List<ConstraintTagData>  _constraintTagDataList=[
    ConstraintTagData(
      day: "Mon",
      date:"25-03-24",
      activity: "Excavation",
      constraint: "Gantry Rail Fixing work not yet started due to non availabliity of Fish Plates & Packing Plates",
      constraintDept: "Purchase team",
      status: "Closed"
    ),
    ConstraintTagData(
        day: "Wed",
        date:"27-03-24",
        activity: "Side Panel Installation",
        constraint: "Awaiting for Comcaster Drawing ",
        constraintDept: "Design team",
        status: "Open"
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "ConstraintTag Data List",
      ),
      body: ListView.builder(
        itemCount: _constraintTagDataList.length,
          itemBuilder: (context,index){
           return Container(
             width: MediaQuery.of(context).size.width*0.95,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               border: Border.all(color: Colors.grey)
             ),
             child: Column(
               children: [

               ],
             ),
           );
          }),
    );
  }
}



class ConstraintTagData{
  String ?day;
  String ?date;
  String ?activity;
  String ?constraintDept;
  String ?constraint;
  String ?location;
  String ?status;

  ConstraintTagData({this.day,this.date,this.activity,this.constraintDept,this.constraint,this.location,this.status});
}
