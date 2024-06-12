import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/draft_week_plan/draft_week_plan_bloc.dart';
import 'package:we_lean/bloc/week_plan/week_plan_bloc.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_bloc.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_event.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_state.dart';
import 'package:we_lean/models/week_activity.dart';
import 'package:we_lean/repo/draft_week_plan_repo.dart';
import 'package:we_lean/repo/week_plan_repo.dart';
import 'package:we_lean/screens/draft_week_plan_list_screen.dart';
import 'package:we_lean/screens/save_forecast_plan_screen.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:we_lean/widgets/custom_button_main.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:we_lean/widgets/custom_textformfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/week_plan/week_plan_event.dart';
import '../bloc/week_plan/week_plan_state.dart';
import '../utils/shared_pref_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button_submit.dart';
import 'review_forecast_plan_screen.dart';

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({Key? key}) : super(key: key);

  @override
  _CreatePlanScreenState createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {


  int ?_draftProjectLocationId;


  late DateTime _selectedDate;
  TextEditingController _qtyController=TextEditingController();

  String? _selectedActivity;
  String? _selectedUnit;
  String? _selectedArea;
  String? _selectedConstraintCode;
  int ?weekNumber;

  String ?selectedAreaKey;
  String ?selectedActivityKey;
  String ?selectedUomKey;
  String selectedConstraintKey='';

  TextEditingController _constraintdescController=TextEditingController();

  WeekActivity?  weekActivity;

  List<WeekActivity> colorWeekactivity=[];

  List<String> _selectedConstraintCodes = [];
  List<String> _selectedConstraintKeys = [];

  Map<DateTime, List<WeekActivity>> plansByDate = {};


  String ?_startWeek;
  int _weeknumber=0;
  int _currentweekCreate=0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeekPlanDataBloc>(context).add(FetchWeekPlanData());
    _selectedDate = DateTime.now();
    _initializeData();
  }


  Future<void> _initializeData() async {
    final sharedPreferencesService = await SharedPreferencesService.instance;
    final String? retrievedStartWeek = sharedPreferencesService.startWeek;
    setState(() {
      _startWeek = retrievedStartWeek;
      _weeknumber = getWeekOfYear(DateTime.now());
      // Calculate current week based on start week
      if (_startWeek != null) {
        _currentweekCreate =_weeknumber - int.parse(_startWeek!) + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarMain(
        title: "Create Plan",
      ),
      body: MultiBlocListener(
        listeners: [
             BlocListener<WeekPlanCreateBloc,WeekPlanCreateState>(
               listener: (context,state){
                 if(state is WeekPlanCreateSuccessState){
                   CustomMessenger.showMessage(context,state.weekPlanResponse.message!,Colors.green);

                 }
                 else if(state is WeekPlanCreateErrorState){
                   CustomMessenger.showMessage(context,state.error,Colors.red);
                 }
               },
             )
        ],
        child:  BlocBuilder<WeekPlanDataBloc,WeekPlanDataState>(
            builder: (context,state) {
              if(state is WeekPlanDataLoaded){
                final activities = state.weekPlanData.activities;
                final categories = state.weekPlanData.categories;
                final uoms = state.weekPlanData.uoms;
                final constraints = state.weekPlanData.constraints;

                DateTime now = DateTime.now();
                DateTime currentMonday = now.subtract(Duration(days: now.weekday - 1));
                DateTime sixthWeekSunday = currentMonday.add(Duration(days: (6*6)+5));

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(

                    children: [
                      Expanded(
                          child:
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text("Select Date",style: titilliumBoldRegular,),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.95,
                                  height: MediaQuery.of(context).size.height*0.2,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:
                                  TableCalendar(
                                    firstDay:currentMonday,
                                    lastDay: sixthWeekSunday ,
                                    calendarFormat:CalendarFormat.week,
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    headerVisible: true,
                                    headerStyle: HeaderStyle(
                                      titleCentered: true,
                                      formatButtonVisible: false,
                                      titleTextStyle: titilliumBoldRegular,
                                      leftChevronIcon: Icon(Icons.chevron_left),
                                      rightChevronIcon: Icon(Icons.chevron_right),
                                      headerPadding: EdgeInsets.symmetric(vertical: 8),
                                      headerMargin: EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(240, 240, 240, 1),
                                      ),
                                      titleTextFormatter: (DateTime focusedDay, _) {
                                        // Display month, year, and week number
                                        final String month = DateFormat('MMMM').format(focusedDay);
                                        final int year = focusedDay.year;

                                        return 'Week ${weekNumber==null?_currentweekCreate:weekNumber}, $month $year';
                                      },
                                    ),
                                    daysOfWeekStyle: DaysOfWeekStyle(
                                        weekdayStyle: titilliumRegular,
                                        weekendStyle: titilliumRegular
                                    ),
                                    calendarStyle: CalendarStyle(
                                      defaultTextStyle: titilliumRegular,
                                      holidayTextStyle: titilliumRegular,
                                      outsideTextStyle: titilliumRegular,
                                      disabledTextStyle: titilliumRegular,
                                      weekendTextStyle: titilliumRegular,
                                      selectedTextStyle: titilliumBoldRegular.copyWith(color: Colors.white),
                                      todayTextStyle: titilliumRegular.copyWith(color: Colors.white),
                                      selectedDecoration: BoxDecoration(
                                          color:CustomColors.themeColor
                                      ),
                                      todayDecoration: BoxDecoration(
                                          color: CustomColors.themeColorOpac
                                      ),
                                    ),
                                    focusedDay: _selectedDate,
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_selectedDate, day);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      setState(() {
                                        weekNumber = getWeekOfYear(selectedDay)-int.parse(_startWeek!)+1;
                                        print(weekNumber);
                                        _selectedDate = selectedDay;
                                      });
                                    },
                                    onPageChanged: (focusedDay) {
                                      setState(() {
                                        weekNumber = getWeekOfYear(focusedDay)-int.parse(_startWeek!)+1;
                                        _selectedDate = focusedDay;
                                      });
                                    },
                                    calendarBuilders: CalendarBuilders(
                                      // Customize the appearance of day cells
                                      selectedBuilder: (context, date, _) {
                                        // Check if plans exist for this date
                                        if (plansByDate.containsKey(date)) {
                                          // Plans exist, return a decorated container
                                          return Container(
                                            margin: const EdgeInsets.all(4.0),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.green, // Change color as needed
                                            ),
                                            child: Text(
                                              date.day.toString(),
                                              style: titilliumBoldRegular.copyWith(color: Colors.white),
                                            ),
                                          );
                                        } else {
                                          // No plans, return the default builder
                                          return null;
                                        }
                                      },
                                    ),
                                    // Other properties...
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text("Select Work-Area",style:titilliumBoldRegular),
                                SizedBox(height: 10,),
                                // Container(
                                //     width: MediaQuery.of(context).size.width*0.95,
                                //     height: MediaQuery.of(context).size.height*0.05,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Color.fromRGBO(240, 240, 240, 1)
                                //     ),
                                //     child: _selectedArea==null?Text(" "):Center(child: Text(_selectedArea!,style: titilliumRegular,))
                                // ),
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
                                          value: _selectedArea,
                                          style: titilliumBoldRegular.copyWith(color: Colors.black54),
                                          hint: Text("Work-Area",style: titilliumRegular,),
                                          items:categories.entries.map((value) {
                                            return DropdownMenuItem(
                                              value: value.value,
                                              child: Text(value.value),
                                            );
                                          }).toList(),
                                          onChanged:(newvalue){
                                            setState(() {
                                              _selectedArea=newvalue;

                                              selectedAreaKey = categories.entries.firstWhere(
                                                    (entry) => entry.value == newvalue,
                                                // orElse: () => MapEntry('', ''), // Default value if not found
                                              ).key;
                                              print('Selected Value: $newvalue, Key: $selectedAreaKey');
                                            });
                                            print(newvalue);
                                          }
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text("Select Activity",style: titilliumBoldRegular,),
                                SizedBox(height: 10,),
                                // Container(
                                //     width: MediaQuery.of(context).size.width*0.95,
                                //     height: MediaQuery.of(context).size.height*0.05,
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Color.fromRGBO(240, 240, 240, 1)
                                //     ),
                                //     child: _selectedActivity==null?Text(" "):Center(child: Text(_selectedActivity!,style: titilliumRegular,))
                                // ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.95,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(240, 240, 240, 1)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: DropdownButton(
                                          elevation: 0,
                                          dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                          value:_selectedActivity,
                                          style: titilliumBoldRegular.copyWith(color: Colors.black54),
                                          hint: Text("Activity",style: titilliumRegular,),
                                          items:activities.map((value) {
                                            return DropdownMenuItem(
                                              value: value.name,
                                              child: Text(value.name),
                                            );
                                          }).toList(),
                                          onChanged:(newvalue){
                                            // List<String> parts = newvalue!.split('|');
                                            // String name = parts[0]; // "Rebar cutting and bending"
                                            // String id = parts[1];   // "12"
                                            // String uomname=parts[2];
                                            // String uomid=parts[3];
                                            setState(() {
                                              // _selectedActivity=name;
                                              // selectedActivityKey=id;
                                              // _selectedUnit=uomname;
                                              // selectedUomKey=uomid;
                                              _selectedActivity=newvalue;
                                              _selectedUnit = activities.firstWhere(
                                                    (activity) => activity.name== newvalue,
                                              ).uomName;
                                              selectedActivityKey= activities.firstWhere(
                                                    (activity) => activity.name== newvalue,
                                              ).id.toString();

                                              selectedUomKey=activities.firstWhere(
                                                    (activity) => activity.name== newvalue,
                                              ).uomId.toString();

                                            });

                                            print(_selectedActivity);
                                            print(selectedActivityKey);
                                          }
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text("Select Qty",style: titilliumBoldRegular,),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.95,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            width: MediaQuery.of(context).size.width*0.64,
                                            height: MediaQuery.of(context).size.height*0.05,
                                            decoration: const BoxDecoration(
                                              // borderRadius: BorderRadius.circular(10),
                                                color: Color.fromRGBO(240, 240, 240, 1)
                                            ),
                                            child: TextFormField(
                                              controller: _qtyController,
                                              keyboardType: TextInputType.number,
                                              cursorColor:  CustomColors.themeColor,
                                              style: titilliumBoldRegular.copyWith(color: Colors.black54),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 8),
                                                fillColor:Color.fromRGBO(240, 240, 240, 1),
                                                filled: true,
                                                hintText: "Qty",
                                                hintStyle: titilliumRegular
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      Container(
                                          width: MediaQuery.of(context).size.width*0.28,
                                          height: MediaQuery.of(context).size.height*0.05,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color.fromRGBO(240, 240, 240, 1)
                                          ),
                                          child: _selectedUnit==null?Padding(
                                            padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02,vertical: MediaQuery.of(context).size.height*0.01),
                                            child: Text("Units",style: titilliumRegular.copyWith(color: Colors.black54),),
                                          ):Center(child: Text(_selectedUnit!,style: titilliumBoldRegular.copyWith(color: Colors.black54),))
                                      )
                                    ],
                                  ),
                                ),
                                // Container(
                                //   width: MediaQuery.of(context).size.width*0.95,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Container(
                                //         width: MediaQuery.of(context).size.width*0.26,
                                //         child: Text("Qty",style: titilliumRegular.copyWith(color: Colors.grey[600])),
                                //       ),
                                //       Container(
                                //         width: MediaQuery.of(context).size.width*0.27,
                                //         child:
                                //         DropdownButtonHideUnderline(
                                //           child: DropdownButton(
                                //               elevation: 0,
                                //               dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                //               hint: Text("Unit",style: titilliumRegular,),
                                //               items:uoms.entries.map(( value) {
                                //                 return DropdownMenuItem(
                                //                   value: value.value,
                                //                   child: Text(value.value),
                                //                 );
                                //               }).toList(),
                                //               onChanged:(newvalue){
                                //                 setState(() {
                                //                   _selectedUnit=newvalue;
                                //
                                //                   selectedUomKey = uoms.entries.firstWhere(
                                //                         (entry) => entry.value == newvalue,
                                //                     // orElse: () => MapEntry('', ''), // Default value if not found
                                //                   ).key;
                                //                   print('Selected Value: $newvalue, Key: $selectedUomKey');
                                //                 });
                                //                 print(_selectedUnit);
                                //               }
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                SizedBox(height: 15,),
                                Text("Select Constraint Code",style: titilliumBoldRegular,),
                                SizedBox(height: 10,),
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.95,
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                    ),
                                    child: _selectedConstraintCodes.isEmpty
                                        ? Text(" ")
                                        : Center(child: Text(_selectedConstraintCodes.join(','), style: titilliumBoldRegular.copyWith(color: Colors.black54),))
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        elevation: 0,
                                        dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                                        hint: Text("Constarint Code", style: titilliumRegular,),
                                        items: constraints.entries.map((value) {

                                          return DropdownMenuItem(
                                            value: value.value,
                                            child: Text(value.value),
                                          );
                                        }).toList(),
                                        onChanged: (newvalue) {
                                          setState(() {
                                            if (_selectedConstraintCodes.contains(newvalue)) {
                                              _selectedConstraintCodes.remove(newvalue);
                                            } else {
                                              _selectedConstraintCodes.add(newvalue!);
                                            }
                                            String? correspondingKey = constraints.entries.firstWhere((entry) => entry.value == newvalue, orElse: () => MapEntry("", "")).key;
                                            if (correspondingKey.isNotEmpty) {
                                              if (_selectedConstraintKeys.contains(correspondingKey)) {
                                                _selectedConstraintKeys.remove(correspondingKey); // Remove key if already exists
                                              } else {
                                                _selectedConstraintKeys.add(correspondingKey); // Add key
                                              }
                                            }
                                          });
                                          _selectedConstraintCode=_selectedConstraintCodes.join(',');
                                          selectedConstraintKey=_selectedConstraintKeys.join(',');
                                          print(_selectedConstraintCode);
                                          print(selectedConstraintKey);
                                          print(_selectedConstraintCodes);
                                        }
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text("Add Constraint Description",style: titilliumBoldRegular,),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.95,

                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(240, 240, 240, 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                    controller: _constraintdescController,
                                    style: titilliumBoldRegular.copyWith(color: Colors.black54),
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
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.95,
                                  child: Text("Constraint Description",style: titilliumRegular.copyWith(color: Colors.grey[600])),
                                ),
                              ],),
                          )),
                      SizedBox(height: 15,),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*0.06,
                              width:MediaQuery.of(context).size.width*0.95,
                              child: CustomSubmitMain(title: "Add Plan", onPressed: (){
                                if(_selectedArea!=null&&_selectedDate!=null&&_selectedActivity!=null&&_qtyController.text!=null&&_selectedUnit!=null){
                                  String formattedDate = DateFormat("dd-MM-yy").format(_selectedDate);
                                  String selectedDay=_getDayOfWeek(_selectedDate);
                                  // print(selectedDay);
                                  print(_selectedConstraintCode);
                                  print(selectedConstraintKey);

                                  weekActivity=WeekActivity(
                                      categoryId: int.parse(selectedAreaKey!),
                                      weekDay: _selectedDate.weekday,
                                      plannedQty: int.parse(_qtyController.text),
                                      activityId: int.parse(selectedActivityKey!),
                                      constraintId: selectedConstraintKey!,
                                      weekDate:  formattedDate,
                                      uomId:int.parse(selectedUomKey!),
                                      description: _constraintdescController.text

                                  );

                                  colorWeekactivity.add(WeekActivity(

                                      activityId: int.parse(selectedActivityKey!),
                                      categoryId: int.parse(selectedAreaKey!),
                                      constraintId: selectedConstraintKey!,
                                      uomId: int.parse(selectedUomKey!),
                                      plannedQty: int.parse(_qtyController.text),
                                      weekDate: formattedDate,
                                      weekDay: _selectedDate.weekday,
                                      day: selectedDay,
                                      activity: _selectedActivity,
                                      category: _selectedArea,
                                      uom: _selectedUnit,
                                      constraint: _selectedConstraintCode,
                                      description: _constraintdescController.text
                                  ));

                                  BlocProvider.of<WeekPlanCreateBloc>(context).add(
                                      PostWeekPlanCreateEvent(
                                          weekPlan: WeekPlan(
                                              userId: AppData.user!.id!,
                                              weekActivity: weekActivity!
                                          ))
                                  );

                                  setState(() {
                                    // _selectedArea=null;
                                    // _selectedActivity=null;
                                    _qtyController.clear();
                                    // _selectedUnit=null;
                                    _selectedConstraintCode=null;
                                    selectedConstraintKey="";
                                    _constraintdescController.clear();
                                    _selectedConstraintKeys.clear();
                                    _selectedConstraintCodes.clear();
                                  });

                                  updatePlansByDate(_selectedDate, colorWeekactivity);
                                  // CustomMessenger.showMessage(context,"Plan data added successfully",Colors.green);
                                }
                                else{
                                  CustomMessenger.showMessage(context,"Plan data should not be empty",Colors.red);
                                }
                              }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height*0.06,
                              width:MediaQuery.of(context).size.width*0.95,
                              child: CustomSubmitMain(title: "Review Plan", onPressed:() async{
                                // if(weekActivity.isNotEmpty){
                                //   CustomMessenger.showMessage(context,"Plan added successfully",Colors.green);
                                //   CustomNavigation.push(context, BlocProvider(
                                //     create: (BuildContext context) {
                                //       return WeekPlanCreateBloc(RealWeekPlanCreationRepo());
                                //     },
                                //     child: ReviewForecastPlanScreen(
                                //       weekActivity: weekActivity,
                                //     ),
                                //   ),);
                                // }
                                // else{
                                //   CustomMessenger.showMessage(context,"Plan should not be empty",Colors.red);
                                // }
                                // activitiesData.clear();
                                // print("Locationid - ${AppData.user!.projectLocation!.id}");
                                await _initializeDataid();
                                // print(AppData.user!.projectLocation!=null);
                                // print(_draftProjectLocationId);
                                CustomNavigation.push(context,BlocProvider(
                                  create: (BuildContext context) {
                                    return DraftWeekPlanBloc(RealDraftWeekPlanRepo());
                                  },
                                  child:  DraftWeekPlanListScreen(projectLocationId:_draftProjectLocationId!,)
                                ),);

                              }
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.themeColorOpac,
                  ),
                );
              }

            }
        ),
      )

    );
  }


  Future<void> _initializeDataid() async {
    final sharedPreferencesService = await SharedPreferencesService.instance;
    final int? retrievedProjectLocationId=sharedPreferencesService.projectLocationId;
    print(retrievedProjectLocationId);

    setState(() {
      _draftProjectLocationId=retrievedProjectLocationId;
    });

   // print(projectLocationId);
   // print(AppData.projectLocation!.id);
  }

  String _getDayOfWeek(DateTime dateTime) {
    final days = ['Mon', 'Tue', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
    return days[dateTime.weekday - 1];
  }


  int getWeekOfYear(DateTime date) {
    int dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    int weekOfYear = ((dayOfYear - date.weekday + 10) / 7).floor() + 1;
    if (weekOfYear < 1) {
      weekOfYear = getWeekOfYear(DateTime(date.year - 1, 12, 31)); // Previous year's last week
    } else if (weekOfYear > 52) {
      // Check if this is week 1 of the next year
      DateTime nextYear = DateTime(date.year + 1, 1, 1);
      if (nextYear.weekday <= DateTime.thursday) {
        weekOfYear = 1;
      }
    }
    return weekOfYear-1;
  }

  // Method to update plansByDate map when a plan is added
  void updatePlansByDate(DateTime date, List<WeekActivity> activities) {
    setState(() {
      plansByDate[date] = activities;
    });
  }

  // Method to remove plans from plansByDate map when needed
  void removePlansForDate(DateTime date) {
    setState(() {
      plansByDate.remove(date);
    });
  }

}


class ActivitiesData{
  String ?date;
  String ?day;
  String ?activity;
  String ?qty;
  String ?unit;
  String ?location;
  String ?constraintCode;
  String ?ConstraintDescription;

  ActivitiesData({
    this.date,
    this.day,
    this.activity,
    this.qty,
    this.unit,
    this.location,
    this.constraintCode,
    this.ConstraintDescription
});
}


class ActivitiesDataPlan{
  DateTime ?date;
  String ?day;
  String ?activity;
  String ?qty;
  String ?unit;
  String ?location;
  String ?constraintCode;
  String ?ConstraintDescription;

  ActivitiesDataPlan({
    this.date,
    this.day,
    this.activity,
    this.qty,
    this.unit,
    this.location,
    this.constraintCode,
    this.ConstraintDescription
  });
}





