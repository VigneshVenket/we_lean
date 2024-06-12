import 'package:flutter/material.dart';

import '../utils/app_data.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_route.dart';
import 'change_password_screen.dart';
import 'logout_screen.dart';


class ProfileScreenManagement extends StatefulWidget {
  const ProfileScreenManagement({Key? key}) : super(key: key);

  @override
  _ProfileScreenManagementState createState() => _ProfileScreenManagementState();
}

class _ProfileScreenManagementState extends State<ProfileScreenManagement> {
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
