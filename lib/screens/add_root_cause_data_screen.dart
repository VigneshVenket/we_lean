import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/update_rootcause/update_rootcause_bloc.dart';
import 'package:we_lean/bloc/update_rootcause/update_rootcause_state.dart';
import 'package:we_lean/bloc/update_rootcause/update_rrotcause_event.dart';
import 'package:we_lean/screens/root_cause_analysis_screen.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../bloc/line_chart_variance_data/line_chart_variance_data_bloc.dart';
import '../bloc/line_chart_variance_data/line_chart_variance_data_event.dart';
import '../repo/line_chart_variance_data_repo.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';


class AddRootCauseDataScreen extends StatefulWidget {
  final int varianceId;
  final String varianceIds;
  final int week_plan_id;
  final Map<int,String> rootCauseTagData;

  const AddRootCauseDataScreen({required this.varianceId,required this.varianceIds,required this.week_plan_id,required this.rootCauseTagData,Key? key}) : super(key: key);

  @override
  _AddRootCauseDataScreenState createState() => _AddRootCauseDataScreenState();
}

class _AddRootCauseDataScreenState extends State<AddRootCauseDataScreen> {
  
  TextEditingController why1Controller=TextEditingController();
  TextEditingController why2Controller=TextEditingController();
  TextEditingController why3Controller=TextEditingController();
  TextEditingController why4Controller=TextEditingController();
  TextEditingController why5Controller=TextEditingController();

  String ?selectedGroupId1;
  String ?selectedGroupId2;
  String ?selectedGroupId3;
  String ?selectedGroupId4;
  String ?selectedGroupId5;

  String ?selectedGroupValue1;
  String ?selectedGroupValue2;
  String ?selectedGroupValue3;
  String ?selectedGroupValue4;
  String ?selectedGroupValue5;

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Add Rootcause",
      ),
      body:BlocListener<RootCauseUpdateBloc,RootCauseUpdateState>(
        listener: (context,state){
           if(state is RootCauseUpdateSuccess){
             why1Controller.clear();
             why2Controller.clear();
             why3Controller.clear();
             why4Controller.clear();
             why5Controller.clear();
             Navigator.of(context).pop();
             CustomNavigation.pushReplacement(context,  MultiBlocProvider(
               providers: [

                 BlocProvider(
                   create: (BuildContext context) {
                     return LineChartVarianceBloc(RealLineChartVarianceDataRepo())
                       ..add(FetchLineChartVarianceData(varianceId: widget.varianceIds));
                   },),
               ],
               child: RootCauseAnalysisScreen(varianceIds:widget.varianceIds,week_plan_id: widget.week_plan_id) ,
             ),);
             CustomMessenger.showMessage(context, state.rootCauseUpdateResponse.status!, Colors.green);
           }else if(state is RootCauseUpdateFailure){
             CustomMessenger.showMessage(context, state.error, Colors.red);
           }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(
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

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(240, 240, 240, 1)
                      ),
                      child:
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              value: selectedGroupValue1,
                              style: titilliumBoldRegular.copyWith(color: Colors.black54),
                              hint: Text("Select Department",style: titilliumRegular,),
                              items:widget.rootCauseTagData.entries.map((value) {
                                return DropdownMenuItem(
                                  value: value.value,
                                  child: Text(value.value),
                                );
                              }).toList(),
                              onChanged:(newvalue){
                                setState(() {
                                  selectedGroupValue1=newvalue;

                                  selectedGroupId1 = widget.rootCauseTagData.entries.firstWhere(
                                        (entry) => entry.value == newvalue,
                                    // orElse: () => MapEntry('', ''), // Default value if not found
                                  ).key.toString();

                                });
                                print(selectedGroupId1);
                              }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    RootCausedataEntry(why1Controller, "Enter Description"),
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

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(240, 240, 240, 1)
                      ),
                      child:
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              value: selectedGroupValue2,
                              style: titilliumBoldRegular.copyWith(color: Colors.black54),
                              hint: Text("Select Department",style: titilliumRegular,),
                              items:widget.rootCauseTagData.entries.map((value) {
                                return DropdownMenuItem(
                                  value: value.value,
                                  child: Text(value.value),
                                );
                              }).toList(),
                              onChanged:(newvalue){
                                setState(() {
                                  selectedGroupValue2=newvalue;

                                  selectedGroupId2 = widget.rootCauseTagData.entries.firstWhere(
                                        (entry) => entry.value == newvalue,
                                    // orElse: () => MapEntry('', ''), // Default value if not found
                                  ).key.toString();

                                });
                                print(selectedGroupId2);
                              }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    RootCausedataEntry(why2Controller, "Enter Descrition"),
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

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(240, 240, 240, 1)
                      ),
                      child:
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              value: selectedGroupValue3,
                              style: titilliumBoldRegular.copyWith(color: Colors.black54),
                              hint: Text("Select Department",style: titilliumRegular,),
                              items:widget.rootCauseTagData.entries.map((value) {
                                return DropdownMenuItem(
                                  value: value.value,
                                  child: Text(value.value),
                                );
                              }).toList(),
                              onChanged:(newvalue){
                                setState(() {
                                  selectedGroupValue3=newvalue;

                                  selectedGroupId3 = widget.rootCauseTagData.entries.firstWhere(
                                        (entry) => entry.value == newvalue,
                                    // orElse: () => MapEntry('', ''), // Default value if not found
                                  ).key.toString();

                                });
                                print(selectedGroupId3);
                              }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    RootCausedataEntry(why3Controller, "Enter Description"),
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

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(240, 240, 240, 1)
                      ),
                      child:
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              value: selectedGroupValue4,
                              style: titilliumBoldRegular.copyWith(color: Colors.black54),
                              hint: Text("Select Department",style: titilliumRegular,),
                              items:widget.rootCauseTagData.entries.map((value) {
                                return DropdownMenuItem(
                                  value: value.value,
                                  child: Text(value.value),
                                );
                              }).toList(),
                              onChanged:(newvalue){
                                setState(() {
                                  selectedGroupValue4=newvalue;

                                  selectedGroupId4 = widget.rootCauseTagData.entries.firstWhere(
                                        (entry) => entry.value == newvalue,
                                    // orElse: () => MapEntry('', ''), // Default value if not found
                                  ).key.toString();

                                });
                                print(selectedGroupId4);
                              }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    RootCausedataEntry(why4Controller, "Enter Description"),
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

                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.95,
                      height: MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(240, 240, 240, 1)
                      ),
                      child:
                      DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                              elevation: 0,
                              dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                              value: selectedGroupValue5,
                              style: titilliumBoldRegular.copyWith(color: Colors.black54),
                              hint: Text("Select Department",style: titilliumRegular,),
                              items:widget.rootCauseTagData.entries.map((value) {
                                return DropdownMenuItem(
                                  value: value.value,
                                  child: Text(value.value),
                                );
                              }).toList(),
                              onChanged:(newvalue){
                                setState(() {
                                  selectedGroupValue5=newvalue;

                                  selectedGroupId5 = widget.rootCauseTagData.entries.firstWhere(
                                        (entry) => entry.value == newvalue,
                                    // orElse: () => MapEntry('', ''), // Default value if not found
                                  ).key.toString();

                                });
                                print(selectedGroupId5);
                              }
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    RootCausedataEntry(why5Controller, "Enter Description"),


                  ],
                ),
              )),
              SizedBox(height: 20,),
              CustomButtonSubmit(title: "Save", onPressed: (){
                BlocProvider.of<RootCauseUpdateBloc>(context).add(RootCauseUpdated(
                    varianceId: widget.varianceId,
                    why1: why1Controller.text, why2: why2Controller.text,
                    why3: why3Controller.text, why4: why4Controller.text, why5: why5Controller.text,groupId1: selectedGroupId1!,
                   groupId2: selectedGroupId2!,groupId3: selectedGroupId3!,groupId4: selectedGroupId4!,groupId5: selectedGroupId5!

                ));
              })

            ],
          ),
        ) ,
      )


    );
  }
  
  
  Widget RootCausedataEntry(TextEditingController controller,String hintText){
    return Container(
      width: MediaQuery.of(context).size.width*0.95,
      height: MediaQuery.of(context).size.height*0.1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240,240, 1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        autofocus: false,
        maxLines: null,
        style: titilliumRegular,
        cursorColor:CustomColors.themeColor,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 5),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(
          //     width: 0,
          //     style: BorderStyle.none,
          //   ),
          // ),
          // filled: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: titilliumRegular

        ),
      ),
    );
    
  }
}
