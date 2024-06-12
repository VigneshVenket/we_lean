import 'package:flutter/material.dart';
import 'package:we_lean/bloc/auth/auth_bloc.dart';
import 'package:we_lean/screens/login_screen.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_button_main.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/shared_pref_service.dart';


class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Logout",
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 110,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.height*0.35,
              child: Image.asset("assets/images/logout_bg.jpg",fit: BoxFit.fill,),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.height*0.06,
              child: CustomSubmitMain(
                title: "Cancel",
                onPressed: (){Navigator.of(context).pop();}
              ),
            ),
            SizedBox(height: 10,),

            BlocConsumer<AuthBloc,AuthState>(
               builder: (context,state){
                 return  Container(
                   width: MediaQuery.of(context).size.width*0.95,
                   height: MediaQuery.of(context).size.height*0.06,
                   child: CustomSubmitMain(
                       title: "Logout",
                       onPressed: (){BlocProvider.of<AuthBloc>(context).add(PerformLogout());}
                   ),
                 );
               },
              listener: (context,state) async{
                 if(state is UnAuthenticated) {
                   final sharedPrefService = await SharedPreferencesService.instance;
                    await sharedPrefService.logoutUser();
                    CustomNavigation.pushAndRemoveUntill(context, LoginScreen());
                 }else if(state is AuthFailed){
                   CustomMessenger.showMessage(context, state.message!, Colors.red);

                 }
              },
            )

          ],
        ),
      ),
    );
  }
}
