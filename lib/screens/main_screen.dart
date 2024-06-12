import 'package:flutter/material.dart';
import 'package:we_lean/bloc/current_week_plan/current_week_plan_bloc.dart';
import 'package:we_lean/bloc/current_week_plan/current_week_plan_event.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_bloc.dart';
import 'package:we_lean/bloc/feed_post/feed_post_bloc.dart';
import 'package:we_lean/bloc/is_like_post/is_like_post_bloc.dart';
import 'package:we_lean/bloc/save_comment/save_comment_bloc.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_bloc.dart';
import 'package:we_lean/repo/current_week_plan_activity_repo.dart';
import 'package:we_lean/repo/discussion_post_delete_repo.dart';
import 'package:we_lean/repo/feed_post_repo.dart';
import 'package:we_lean/repo/is_like_post_repo.dart';
import 'package:we_lean/repo/save_comment_repo.dart';
import 'package:we_lean/repo/user_location_plan_repo.dart';
import 'package:we_lean/screens/actions_week_screen.dart';
import 'package:we_lean/screens/create_plan_screen.dart';
import 'package:we_lean/screens/create_plan_trail.dart';
import 'package:we_lean/screens/daily_paln_screen.dart';
import 'package:we_lean/screens/forecast_plan_screen.dart';
import 'package:we_lean/screens/plan_approval_screen.dart';
import 'package:we_lean/screens/posts_screen.dart';
import 'package:we_lean/screens/profile%20_screen_v2.dart';
import 'package:we_lean/screens/profile_screen.dart';
import 'package:we_lean/screens/variance_weekly.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_bottomnavigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/approval_data/approval_bloc.dart';
import '../bloc/bar_chart_ppc/bar_chart_ppc_bloc.dart';
import '../bloc/bar_chart_ppc/bar_chart_ppc_event.dart';
import '../bloc/overall_ppc_data/overall_ppc_data_bloc.dart';
import '../bloc/overall_ppc_data/overall_ppc_data_event.dart';
import '../bloc/today_plan/toay_plan_event.dart';
import '../bloc/today_plan/today_plan_bloc.dart';
import '../bloc/user_location_plan/user_location_plan_event.dart';
import '../bloc/week_plan_data/week_plan_data_bloc.dart';
import '../bloc/week_plan_data/week_plan_data_event.dart';
import '../bloc/week_variance_graph/week_variance_graph_bloc.dart';
import '../bloc/week_variance_graph/week_variance_graph_event.dart';
import '../repo/approval_data_repo.dart';
import '../repo/bar_chart_ppc_repo.dart';
import '../repo/overall_ppc_data_repo.dart';
import '../repo/today_plan_repo.dart';
import '../repo/week_plan_data_repo.dart';
import '../repo/week_variance_graph_repo.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex= 0;

  final List<Widget> _screens = [

     MultiBlocProvider(
      providers: [
        AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?BlocProvider(
          create: (BuildContext context) {
            return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
              ..add(FetchWeekVariancePPCData(userId: AppData.user!.id!));
          },):
        BlocProvider(
          create: (BuildContext context) {
            return WeekVariancePPCBloc(RealWeekVariancePpcRepo())
              ..add(FetchWeekVariancePPCDataLocationwise(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));
          },),

        AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?BlocProvider(
          create: (BuildContext context) {
            return TodayPlanBloc(todayPlanRepo: RealTodayPlanRepo())
              ..add(FetchTodayPlan(userId: AppData.user!.id!));
          },):
        BlocProvider(
          create: (BuildContext context) {
            return TodayPlanBloc(todayPlanRepo: RealTodayPlanRepo())
              ..add(FetchTodayPlanLocationwise(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));
          },),

        AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?BlocProvider(
          create: (BuildContext context) {
            return BarChartBloc(barChartPpcRepo: RealBarChartPpcRepo())
              ..add(FetchBarChartDataEvent(userId: AppData.user!.id!));
          },):
        BlocProvider(
          create: (BuildContext context) {
            return BarChartBloc(barChartPpcRepo: RealBarChartPpcRepo())
              ..add(FetchBarChartDataLocationwiseEvent(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));
          },),

        AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"? BlocProvider(
          create: (BuildContext context) {
            return OverallPPCBloc(overallPpcDataRepo: RealOverallPpcDataRepo())
              ..add(FetchOverallPPCDataEvent(userId: AppData.user!.id!));
          },):
        BlocProvider(
          create: (BuildContext context) {
            return OverallPPCBloc(overallPpcDataRepo: RealOverallPpcDataRepo())
              ..add(FetchOverallPPCDataLocationwiseEvent(userId: AppData.user!.id!,projLocId: AppData.projectLocation!.id));
          },),
      ],
      child: HomeScreen(),
    ),

    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
    BlocProvider(
      create: (BuildContext context) {
        return WeekPlanDataBloc(RealWeekPlanDataRepo())
          ..add(FetchWeekPlanData());
      }, child: CreatePlanScreen(),):AppData.user!.role_name=="Construction Manager"?
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context){
            return UserLocationPlanBloc(RealUserLocationPlanRepo());
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return ApprovalBloc(RealApprovalDataRepo());
          },),

      ], child: PlanApprovalScreen(),
    ):  BlocProvider(
        create: (BuildContext context) {
      return UserLocationPlanBloc(RealUserLocationPlanRepo());
    }, child:  VarianceWeekly(),
  ),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(BuildContext context) {
            return FeedPostsBloc(RealFeedPostsRepo());
          } ,
        ),
        BlocProvider(
          create:(BuildContext context) {
            return SaveCommentBloc(RealSaveCommentRepo());
          } ,
        ),
        BlocProvider(
          create:(BuildContext context) {
            return LikePostBloc(likePostRepo: RealLikePostRepo());
          } ,
        ),
        BlocProvider(
          create:(BuildContext context) {
            return DiscussionPostDeleteBloc(RealDiscussionPostDeleteRepo());
          } ,
        ),
      ],
      child:PostsScreen()
    ),



    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
    BlocProvider(
      create: (BuildContext context) {
        return UserLocationPlanBloc(RealUserLocationPlanRepo())
          ..add(FetchUserLocationPlanEvent(AppData.user!.id!));
      },
      child: ForecastPlanScreen(),
    ):AppData.user!.role_name=="Construction Manager"?
    BlocProvider(
      create: (BuildContext context) {
        return UserLocationPlanBloc(RealUserLocationPlanRepo());
      }, child:  VarianceWeekly(),
    ):   BlocProvider(
        create: (BuildContext context) {
      return UserLocationPlanBloc(RealUserLocationPlanRepo());
    },child:    ActionWeekScreen(),
  ),
    AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Construction Manager"?
    BlocProvider(
      create: (BuildContext context) {
        return CurrentWeekPlanBloc(RealCurrentWeekPlanRepo())
          ..add(FetchCurrentWeekPlanEvent(userId: AppData.user!.id!));
      },
      child:  DailyPlanScreen(),
      ): BlocProvider(
         create: (BuildContext context) {
         return CurrentWeekPlanBloc(RealCurrentWeekPlanRepo())
         ..add(FetchCurrentWeekPlanLocationwiseEvent(userId: AppData.user!.id!,proj_loc_id: AppData.projectLocation!.id));
         },
      child:  DailyPlanScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (selectedIndex != 0) {

            setState(() {
               selectedIndex=0;
            });

          return false; // Do not exit the app
        } else {
          // Otherwise, handle the back button normally
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens[selectedIndex],
        bottomNavigationBar: MyBottomNavigation(
          selectedIndex: selectedIndex,
          onTabChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
