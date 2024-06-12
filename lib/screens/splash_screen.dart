import 'dart:async';

import 'package:flutter/material.dart';
import 'package:we_lean/models/location_data.dart';
import 'package:we_lean/screens/login_screen.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../bloc/auth/auth_bloc.dart';
import '../models/user.dart';
import '../utils/app_data.dart';
import '../utils/shared_pref_service.dart';
import '../utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isNewUser = false;


  @override
  void initState() {
    _init();
    navigateToLoginScreen();
    super.initState();
  }


  void navigateToLoginScreen() {
    Timer(Duration(seconds: 3), () {
      CustomNavigation.pushReplacement(context,isNewUser?LoginScreen():MainScreen());
    });

  }

  Future<void> _init() async {
    isNewUser = await checkIfUserLoggedIn();
    setState(() {});
  }


  Future<bool> checkIfUserLoggedIn() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    int? userId = sharedPrefService.userId;
    int? proj_loc_id=sharedPrefService.projectLocationId;
    String? proj_loc_name=sharedPrefService.projectLocationName;

    if (userId != null) {
         if(proj_loc_id!=null){
           Location loc=Location(id: proj_loc_id, name: proj_loc_name!);
           AppData.projectLocation=loc;

           User user = User();
           user.id = userId;
           user.name = sharedPrefService.userName;
           user.email = sharedPrefService.userEmail;
           user.role_name=sharedPrefService.userRole;
           user.token = sharedPrefService.userToken;
           AppData.user = user;
           AppData.accessToken = user.token;
           BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(user));

           return false;
         }else{
           User user = User();
           user.id = userId;
           user.name = sharedPrefService.userName;
           user.email = sharedPrefService.userEmail;
           user.token = sharedPrefService.userToken;
           user.role_name=sharedPrefService.userRole;
           AppData.user = user;
           AppData.accessToken = user.token;
           BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(user));

           return false;
         }

    }

    // New user
    setState(() {
      isNewUser = true;
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150.0,
                    height:150.0,
                    child: Image.asset(
                      "assets/images/We Lean New Logo 16-08-2023.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Ultimate Project Partner",
                    style: titilliumBold
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
