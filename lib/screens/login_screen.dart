
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/bar_chart_ppc/bar_chart_ppc_bloc.dart';
import 'package:we_lean/bloc/bar_chart_ppc/bar_chart_ppc_event.dart';
import 'package:we_lean/bloc/location/location_bloc.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_bloc.dart';
import 'package:we_lean/bloc/overall_ppc_data/overall_ppc_data_event.dart';
import 'package:we_lean/bloc/today_plan/toay_plan_event.dart';
import 'package:we_lean/bloc/today_plan/today_plan_bloc.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_bloc.dart';
import 'package:we_lean/bloc/week_variance_graph/week_variance_graph_event.dart';
import 'package:we_lean/repo/bar_chart_ppc_repo.dart';
import 'package:we_lean/repo/location_repo.dart';
import 'package:we_lean/repo/overall_ppc_data_repo.dart';
import 'package:we_lean/repo/today_plan_repo.dart';
import 'package:we_lean/repo/week_variance_graph_repo.dart';
import 'package:we_lean/screens/forget_password_screeen.dart';
import 'package:we_lean/screens/home_screen.dart';
import 'package:we_lean/screens/location_display_screen.dart';
import 'package:we_lean/screens/register%20screen.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:we_lean/widgets/custom_textformfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../utils/app_data.dart';
import '../utils/shared_pref_service.dart';
import 'main_screen.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController? _userIdController=TextEditingController();
  TextEditingController? _passwordController=TextEditingController();

  bool isEnabled=true;

  List<String> previousEmployeeIds = [];
  AutoCompleteTextField? employeeIdTextField;

  @override
  void initState() {
    // TODO: implement initState
    _loadSavedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    employeeIdTextField = AutoCompleteTextField<String>(
      key: GlobalKey(),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: 0),
          fillColor:Color.fromRGBO(240, 240, 240, 1),
          filled: true,
          hintText:"Employee Id",
          hintStyle: titilliumBoldRegular,
          prefixIcon: Icon(
            Icons.person,
            size: 16,
            color:Color.fromRGBO(0, 0, 0, 1) ,
          )),
      controller: _userIdController,
      cursorColor: CustomColors.themeColor,
      clearOnSubmit: false,
      suggestions: previousEmployeeIds,
      itemBuilder: (BuildContext context, String suggestion) {
        return ListTile(
          title: Text(suggestion,style: titilliumRegular,),
        );
      },
      itemSubmitted: (String value) {
        setState(() {
          _userIdController!.text = value;
        });
      },
      itemSorter: (String a, String b) {
        return a.compareTo(b);
      },
      itemFilter: (String suggestion, String input) {
        return suggestion.toLowerCase().startsWith(input.toLowerCase());
      },
    );

    return Scaffold(
      body:BlocConsumer<AuthBloc, AuthState>(
         builder: (context,state)=> SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 10),
             child: Column(
               children: [
                 SizedBox(
                   height: 200,
                 ),
                 Container(
                   width: 110,
                   height: 110,
                   child: Image.asset("assets/images/We Lean New Logo 16-08-2023.png",fit: BoxFit.fill,),
                 ),
                 SizedBox(height: 40,),
                 Padding(
                   padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.74),
                   child: Text("SignIn",style: titilliumTitle,),
                 ),
                 SizedBox(height: 20,),
                 SizedBox(
                     width: MediaQuery.of(context).size.width*0.95,
                     height: MediaQuery.of(context).size.height*0.06,
                     child: employeeIdTextField
                     // CustomTextFormField(
                     //   controller: _userIdController!,
                     //   obscureText: false,
                     //   hintText: "Employee Id",
                     //   icon: Icons.person,
                     // )
                 ),
                 SizedBox(height: 10,),
                 SizedBox(
                     width: MediaQuery.of(context).size.width*0.95,
                     height: MediaQuery.of(context).size.height*0.06,
                     child: TextFormField(
                       controller: _passwordController,
                       obscureText: isEnabled,
                       cursorColor:  CustomColors.themeColor,
                       decoration: InputDecoration(
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                             borderSide: const BorderSide(
                               width: 0,
                               style: BorderStyle.none,
                             ),
                           ),
                           contentPadding: const EdgeInsets.symmetric(
                               vertical: 0, horizontal: 0),
                           fillColor:Color.fromRGBO(240, 240, 240, 1),
                           filled: true,
                           hintText:"Password",
                           hintStyle: titilliumBoldRegular,
                           prefixIcon: Icon(
                             Icons.lock,
                             size: 16,
                             color:Color.fromRGBO(0, 0, 0, 1) ,
                           ),
                           suffixIcon: isEnabled
                               ? IconButton(
                               onPressed: () {
                                 setState(() {
                                   isEnabled = !isEnabled;
                                 });
                               },
                               icon: Icon(Icons.visibility_off,
                                   size: 16,
                                   color: Color.fromRGBO(0, 0, 0, 1)))
                               : IconButton(
                               onPressed: () {
                                 setState(() {
                                   isEnabled = !isEnabled;
                                 });
                               },
                               icon: Icon(Icons.visibility,
                                   size: 16,
                                   color: Color.fromRGBO(0, 0, 0, 1)))
                       ),
                     )
                 ),
                 // Padding(
                 //   padding:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.52),
                 //   child: TextButton(
                 //     onPressed: (){
                 //       CustomNavigation.push(context, ForgetPasswordScreen());
                 //     },
                 //     child: Center(
                 //       child: Text("Forgot Password ?",style: titilliumBoldRegular.copyWith(
                 //           color: Color.fromRGBO(0, 0, 0, 1)
                 //       ) ,),
                 //     ),
                 //   ),
                 // ),
                 SizedBox(height: 20,),
                 CustomButton(
                   title: "Sign In",
                   onPressed: () {

                     BlocProvider.of<AuthBloc>(context).add(PerformLogin(
                         _userIdController!.text, _passwordController!.text));

                   },
                 ),
                 SizedBox(height: 10,),
                 // Row(
                 //   mainAxisAlignment: MainAxisAlignment.center,
                 //   children: [
                 //     Text("Don't have an account ?",style: titilliumRegular.copyWith(
                 //         color: Color.fromRGBO(0, 0, 0, 1))),
                 //     TextButton(onPressed: (){
                 //       CustomNavigation.push(context, RegisterScreen());
                 //     }, child: Text("SignUp",
                 //       style: titilliumBoldRegular.copyWith(
                 //           color: Color.fromRGBO(0, 0, 0, 1)
                 //       ) ,
                 //     ))
                 //   ],
                 // )

               ],
             ),
           ),
         ),
         listener: (context,state) async{
           if (state is AuthLogin) {
             AppData.user = state.user;
             AppData.accessToken = state.user?.token;

             final sharedPrefService = await SharedPreferencesService.instance;
             await sharedPrefService.setUserID(state.user!.id!);
             await sharedPrefService.setUserName(state.user!.name!);
             await sharedPrefService.setUserEmpId(state.user!.emp_id!);
             await sharedPrefService.setUserRole(state.user!.role_name!);
             await sharedPrefService.setUserEmail(state.user!.email!);
             await sharedPrefService.setUserToken(state.user!.token!);
             await sharedPrefService.setStartWeek(state.user!.startweek!);
             if(AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"){
                print(state.user!.projectLocation!.id);
                AppData.user!.projectLocation!=state.user!.projectLocation!;

               await sharedPrefService.setProjectLocationName(state.user!.projectLocation!.description);
               await sharedPrefService.setProjectLocationId(state.user!.projectLocation!.id);

             }

             // print(state.user!.startweek);

             _saveCredentials();


            CustomMessenger.showMessage(context, state.message!,Colors.green);

             AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?
             CustomNavigation.pushAndRemoveUntill(context,

              // BlocProvider(
              //   create: (BuildContext context) {
              //     return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
              //       ..add(FetchWeekVariancePPCData(userId: AppData.user!.id!));
              //   },
              // child: MainScreen(),
              // ),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (BuildContext context) {
                        return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
                          ..add(FetchWeekVariancePPCData(userId: AppData.user!.id!));
                      },),
                    BlocProvider(
                      create: (BuildContext context) {
                        return TodayPlanBloc(todayPlanRepo: RealTodayPlanRepo())
                            ..add(FetchTodayPlan(userId: AppData.user!.id!));
                      },),
                    BlocProvider(
                      create: (BuildContext context) {
                        return BarChartBloc(barChartPpcRepo: RealBarChartPpcRepo())
                          ..add(FetchBarChartDataEvent(userId: AppData.user!.id!));
                      },),
                    BlocProvider(
                      create: (BuildContext context) {
                        return OverallPPCBloc(overallPpcDataRepo: RealOverallPpcDataRepo())
                          ..add(FetchOverallPPCDataEvent(userId: AppData.user!.id!));
                      },),
                  ],
                  child: MainScreen(),
                )
            ):
             CustomNavigation.pushAndRemoveUntill(context,

                 // BlocProvider(
                 //   create: (BuildContext context) {
                 //     return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
                 //       ..add(FetchWeekVariancePPCData(userId: AppData.user!.id!));
                 //   },
                 // child: MainScreen(),
                 // ),
                 MultiBlocProvider(
                   providers: [
                     BlocProvider(
                       create: (BuildContext context) {
                         return LocationsBloc(locationRepo: RealLocationRepo());
                       },),
                   ],
                   child: LocationScreen()
                 )
             );
           }

          else if (state is AuthLoginFailed) {
              print(state.message);
             CustomMessenger.showMessage(context, state.message!,Colors.red);

           }
         },
      )

    );
  }




  _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedEmployeeIds = prefs.getStringList('employeeIds');
    if (savedEmployeeIds != null) {
      setState(() {
        previousEmployeeIds = savedEmployeeIds;
      });
    }
  }

  _filterSuggestions(String value) {
    return previousEmployeeIds.where((id) => id.startsWith(value)).toList();
  }

  _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedEmployeeIds = [if (!previousEmployeeIds.contains(_userIdController!.text)) _userIdController!.text, ...previousEmployeeIds];
    await prefs.setStringList('employeeIds', updatedEmployeeIds);
  }
}
