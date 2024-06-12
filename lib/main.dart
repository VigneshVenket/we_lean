import 'package:flutter/material.dart';
import 'package:we_lean/bloc/add_variancelog_action/add_variancelog_action_bloc.dart';
import 'package:we_lean/bloc/current_week_plan/current_week_plan_bloc.dart';
import 'package:we_lean/bloc/delete_constraint/delete_constraint_bloc.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_bloc.dart';
import 'package:we_lean/bloc/week_plan/week_plan_bloc.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_bloc.dart';
import 'package:we_lean/repo/add_action_repo.dart';
import 'package:we_lean/repo/auth_repo.dart';
import 'package:we_lean/repo/current_week_plan_activity_repo.dart';
import 'package:we_lean/repo/delete_constraint_repo.dart';
import 'package:we_lean/repo/user_location_plan_repo.dart';

import 'package:we_lean/repo/week_plan_data_repo.dart';
import 'package:we_lean/repo/week_plan_repo.dart';
import 'package:we_lean/repo/weekly_plan_repo.dart';
import 'package:we_lean/screens/profile_screen.dart';
import 'package:we_lean/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/utils/shared_pref_service.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/weekly_plan/weekly_plan_bloc.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance;
  runApp(
      MultiBlocProvider(
        providers: [
           BlocProvider(create: (context) => AuthBloc(RealAuthRepo())),
           BlocProvider(create: (context) => WeekPlanDataBloc(RealWeekPlanDataRepo())),
           BlocProvider(create: (context) => UserLocationPlanBloc(RealUserLocationPlanRepo())),
           BlocProvider(create: (context) => WeekPlanCreateBloc(RealWeekPlanCreationRepo())),
           BlocProvider(create: (context) => WeeklyPlanBloc(RealWeeklyPlanRepo())),
           BlocProvider(create: (context) => CurrentWeekPlanBloc(RealCurrentWeekPlanRepo())),
           BlocProvider(create: (context) => AddVariancelogActionBloc(addVarianceLogActionRepo: RealAddVarianceLogActionRepo())),
           BlocProvider(create: (context) => ConstraintLogBloc(RealDeleteConstraintRepo())),
        ],
        child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}

