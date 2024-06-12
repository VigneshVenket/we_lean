import 'package:flutter/material.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_messenger.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';


class AddActionsScreen extends StatefulWidget {
  const AddActionsScreen({Key? key}) : super(key: key);

  @override
  _AddActionsScreenState createState() => _AddActionsScreenState();
}

class _AddActionsScreenState extends State<AddActionsScreen> {

  List<RootCauseData>  rootCauseDataList=[
    RootCauseData(
      day: "Mon",
      date: "01-04-24",
      plan: 3,
      actual: 2,
      ppc: 95
    ),
    RootCauseData(
        day: "Tue",
        date: "02-04-24",
        plan: 3,
        actual: 2,
        ppc: 95
    ),
    RootCauseData(
        day: "Wed",
        date: "03-04-24",
        plan: 3,
        actual: 2,
        ppc: 95
    ),
    RootCauseData(
        day: "Thurs",
        date: "04-04-24",
        plan: 3,
        actual: 2,
        ppc: 95
    ),
    RootCauseData(
        day: "Fri",
        date: "05-04-24",
        plan: 3,
        actual: 2,
        ppc: 95
    ),
    RootCauseData(
        day: "Sat",
        date: "06-04-24",
        plan: 3,
        actual: 2,
        ppc: 95
    ),
    RootCauseData(
        day: "Sun",
        date: "07-04-24",
        plan: 3,
        actual: 2,
        ppc: 95
    )
  ];

  List<String>  nonAchievementActivities=[
    "Excavation",
    "Electrical Wiring",
    "Concrete Pouring"
  ];

  List<String>  varianceRoot=[
    "Manpower",
    "Material Supply",
    "Machinery"
  ];

  String ?_selectedActivity;
  String ?_selectedVarianceRoot;
  TextEditingController _actionController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Add Action - Week 13",
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          // Container(
          //   width: MediaQuery.of(context).size.width*0.95,
          //   height: MediaQuery.of(context).size.height*0.06,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: CustomColors.themeColor
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text("Location : Greenways",style: titilliumBoldRegular.copyWith(color: Colors.white),),
          //       Text("Week : 9",style: titilliumBoldRegular.copyWith(color: Colors.white)),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10,),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.95,

                child: ListView.builder(
                    itemCount:rootCauseDataList.length ,
                    itemBuilder: (context,index){
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
                                  child: Icon(Icons.transfer_within_a_station,size: 24,color: Colors.white,),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.21,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 1,),
                                      Text(rootCauseDataList[index].day!,style: titilliumBoldRegular,),
                                      SizedBox(height: 10,),
                                      Text(rootCauseDataList[index].date!,style: titilliumBoldRegular,),
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
                                          // Container(
                                          //     width: MediaQuery.of(context).size.width*0.13,
                                          //     decoration: BoxDecoration(
                                          //         color: Color.fromRGBO(240, 240, 240, 1),
                                          //         borderRadius: BorderRadius.circular(5)
                                          //     ),
                                          //     child: Center(child: Text('Var',style: titilliumBoldRegular,))),
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
                                              child: Center(child: Text(rootCauseDataList[index].plan.toString(),style: titilliumRegular.copyWith(color: Colors.white),))),
                                          Container(
                                              width: MediaQuery.of(context).size.width*0.16,
                                              height: MediaQuery.of(context).size.height*0.03,
                                              decoration: BoxDecoration(
                                                  color:CustomColors.themeColorOpac,
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child:Center(child: Text(rootCauseDataList[index].actual.toString(),style:  titilliumRegular.copyWith(color: Colors.white)),)
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
                                              child:Center(child: Text(rootCauseDataList[index].ppc.toString()+"%",style: titilliumRegular.copyWith(color: Colors.white),),)
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
                                                 _showActionUpdateDialog(context);
                                            }, child:Text("Add Action",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
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
      ),
    );
  }


  void _showActionUpdateDialog(BuildContext context){
     showDialog(
         context: context,
         builder: (context){
            return AlertDialog(
              title: Container(
                height: MediaQuery.of(context).size.height*0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.themeColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Mon",style: titilliumBoldRegular.copyWith(color: Colors.white),),
                    Text("01-04-24",style: titilliumBoldRegular.copyWith(color: Colors.white),),
                  ],
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Activity",style:titilliumBoldRegular,),
                    SizedBox(height: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: DropdownButton(
                              isExpanded: true,
                              padding: EdgeInsets.only(left: 17),
                              value: _selectedActivity,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedActivity= newValue!;
                                });
                              },
                              items: nonAchievementActivities.map((String status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status,style: titilliumRegular,),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Text("Variance",style:titilliumBoldRegular,),
                    SizedBox(height: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 240, 240, 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: DropdownButton(
                              isExpanded: true,
                              padding: EdgeInsets.only(left: 17),
                              value: _selectedVarianceRoot,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedVarianceRoot= newValue!;
                                });
                              },
                              items: varianceRoot.map((String status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status,style: titilliumRegular,),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Text("Action",style:titilliumBoldRegular,),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
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
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.36,
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
                          Navigator.of(context).pop();
                      }, child:Text("Cancel",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                  )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.36,
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
                        CustomMessenger.showMessage(context, "Action added successfully",Colors.green);
                        Navigator.of(context).pop();
                      }, child:Text("Add",style: titilliumBoldRegular.copyWith(color: CustomColors.themeColor)
                  )),
                ),
              ],
            );
         });

  }
}


class RootCauseData{
  String ?date;
  String ?day;
  int ?plan;
  int ?actual;
  int ?ppc;

  RootCauseData({
    this.date,this.day,this.plan,this.actual,this.ppc
});
}
