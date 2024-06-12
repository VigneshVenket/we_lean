import 'package:flutter/material.dart';
import 'package:we_lean/widgets/custom_appbar.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';
import 'create_plan_screen.dart';


class ViewPlanScreen extends StatefulWidget {
  String ?date;
  String ?day;

  ViewPlanScreen({this.date,this.day,Key? key}) : super(key: key);

  @override
  _ViewPlanScreenState createState() => _ViewPlanScreenState();
}

class _ViewPlanScreenState extends State<ViewPlanScreen> {

  List<ActivitiesData>  ?activitiesData=[
    ActivitiesData(
        location: "Casting Area",
        activity: "Concrete Pouring",
        constraintCode: "Manpower",
        qty: "20",
        unit: "sqm"
    ),
    ActivitiesData(
        location: "Ring Casting",
        activity: "Excavation",
        constraintCode: "Subcontractor",
        qty: "50",
        unit: "m"
    ),
    ActivitiesData(
        location: "DG Shed",
        activity: "Electrical Wiring",
        constraintCode: "Manpower",
        qty: "30",
        unit: "m"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Daily Plan",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
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
                        widget.day!,
                        style: titilliumSemiBold.copyWith(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        widget.date!,
                        style: titilliumSemiBold.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: activitiesData!.length,
              itemBuilder: (context, index) {
                var activity = activitiesData![index];
                return
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 12,top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.148,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(240, 240, 240, 1)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          child: Icon(Icons.location_pin,color: Colors.white,size: 18,)),
                                      SizedBox(width: 5,),
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.23,
                                          child: Text("Location ",style: titilliumRegular,)),
                                      Text(": ${activity.location!}",style: titilliumBoldRegular,),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                  Row(
                                    children: [
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.07,
                                          height: MediaQuery.of(context).size.height*0.03,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: CustomColors.themeColorOpac
                                          ),
                                          child: Icon(Icons.task,color: Colors.white,size: 18,)),
                                      SizedBox(width: 5,),
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.23,
                                          child: Text("Activity  ",style: titilliumRegular,)),
                                      Text(": ${activity.activity!}",style: titilliumBoldRegular,),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                  Row(
                                    children: [
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.07,
                                          height: MediaQuery.of(context).size.height*0.03,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: CustomColors.themeColorOpac
                                          ),
                                          child: Icon(Icons.queue,color: Colors.white,size: 18,)),
                                      SizedBox(width: 5,),
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.23,
                                          child: Text("Qty  ",style: titilliumRegular,)),
                                      Text(": ${activity.qty}${activity.unit}",style:titilliumBoldRegular,),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                                  Row(
                                    children: [
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.07,
                                          height: MediaQuery.of(context).size.height*0.03,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: CustomColors.themeColorOpac
                                          ),
                                          child: Icon(Icons.error,color: Colors.white,size: 18,)),
                                      SizedBox(width: 5,),
                                      Container(
                                          width:MediaQuery.of(context).size.width*0.23,
                                          child: Text("Constraint ",style: titilliumRegular,)),
                                      Text(": ${activity.constraintCode==null?"-":activity.constraintCode}",style:titilliumBoldRegular,),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
