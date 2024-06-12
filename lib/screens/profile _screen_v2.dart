import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_bloc.dart';
import 'package:we_lean/bloc/user_location_plan/user_location_plan_event.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_bloc.dart';
import 'package:we_lean/bloc/week_plan_data/week_plan_data_event.dart';
import 'package:we_lean/repo/user_location_plan_repo.dart';
import 'package:we_lean/repo/week_plan_data_repo.dart';
import 'package:we_lean/screens/actions_daily_screen.dart';
import 'package:we_lean/screens/actions_week_screen.dart';
import 'package:we_lean/screens/change_password_screen.dart';
import 'package:we_lean/screens/constraints_tag_list_screen.dart';
import 'package:we_lean/screens/create_plan_screen.dart';
import 'package:we_lean/screens/forecast_plan_screen.dart';
import 'package:we_lean/screens/logout_screen.dart';
import 'package:we_lean/screens/plan_approval_screen.dart';
import 'package:we_lean/utils/app_constants.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../utils/styles.dart';
import '../widgets/custom_appbar.dart';
import 'add_actions_screen.dart';



class ProfileScreenV2 extends StatefulWidget {
  const ProfileScreenV2({Key? key}) : super(key: key);

  @override
  _ProfileScreenV2State createState() => _ProfileScreenV2State();
}

class _ProfileScreenV2State extends State<ProfileScreenV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Profile',

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.12,
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(color: Colors.grey),
                        color: CustomColors.themeColorOpac
                    ),
                    child: Icon(Icons.person_sharp,size: 45,color: Colors.white,),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppData.user!.name!,style: titilliumBoldRegular.copyWith(color: Colors.black)),
                      SizedBox(height: 5,),
                      Text(AppData.user!.email!,style: titilliumRegular),
                      SizedBox(height: 5),
                      Text(AppData.user!.role_name!,style: titilliumRegular),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            Divider(),
            SizedBox(height: 20,),
            GestureDetector(
                onTap: (){CustomNavigation.push(context, BlocProvider(
                  create: (BuildContext context) {
                    return WeekPlanDataBloc(RealWeekPlanDataRepo())
                      ..add(FetchWeekPlanData());
                  },
                  child: CreatePlanScreen(),
                ),);},
                child: CustomListProfileTile("Create Plan", Icons.schedule_outlined,)),
            SizedBox(height: 20,),
            Divider(),
            SizedBox(height: 20,),
            GestureDetector(
                onTap: (){CustomNavigation.push(context, BlocProvider(
                  create: (BuildContext context) {
                    return UserLocationPlanBloc(RealUserLocationPlanRepo())
                      ..add(FetchUserLocationPlanEvent(AppData.user!.id!));
                  },
                  child: ForecastPlanScreen(),
                ),);},
                child: CustomListProfileTile("My Plan", Icons.mail)),
            SizedBox(height: 20,),
            Divider(),
            // SizedBox(height: 20,),
            // GestureDetector(
            //     onTap: (){CustomNavigation.push(context, AddActionsScreen());},
            //     child: CustomListProfileTile("Add Actions", Icons.transfer_within_a_station)),
            // SizedBox(height: 20,),
            // Divider(),
            // SizedBox(height: 20,),
            // GestureDetector(
            //     onTap: (){CustomNavigation.push(context, ChangePasswordScreen());},
            //     child: CustomListProfileTile("Change Passsword", Icons.admin_panel_settings_outlined)),
            // SizedBox(height: 20,),
            // Divider(),
            SizedBox(height: 20,),
            GestureDetector(
                onTap: (){CustomNavigation.push(context, LogoutScreen());},
                child: CustomListProfileTile("Logout", Icons.logout)),
            SizedBox(height: 20,),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget CustomListProfileTile(String title,IconData icon,){
    return    ListTile(
      leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color:CustomColors.themeColorOpac,
              borderRadius: BorderRadius.circular(10)
          ),
         child:Icon(icon,color: Colors.white,) ,
      ),
      title: Text(title,style: titilliumSemiBold,),
      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16,),
    );
  }
}


