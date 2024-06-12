import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';

class MyBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  MyBottomNavigation({Key? key,required this.selectedIndex,required this.onTabChanged}) : super(key: key);

  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      // backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      selectedItemColor: CustomColors.themeColor,
      unselectedItemColor:Color.fromRGBO(120, 120, 120, 1),
      selectedLabelStyle: titilliumBoldRegular,
      unselectedLabelStyle: titilliumBoldRegular,
      onTap: widget.onTabChanged,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,size: 24,),
          label: 'Home',
          backgroundColor: CustomColors.themeColor,
        ),

        AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule_outlined,size: 24),
          label: 'Create',
          backgroundColor: CustomColors.themeColor,
        ):AppData.user!.role_name=="Construction Manager"?
        BottomNavigationBarItem(
          icon: Icon(Icons.mail_outlined,size: 24),
          label: 'Approvals',
          backgroundColor: CustomColors.themeColor,
        ):BottomNavigationBarItem(
          icon: Icon(Icons.contactless_outlined,size: 24),
          label: 'Variance',
          backgroundColor: CustomColors.themeColor,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.api_outlined,size: 24),
          label: 'Posts',
          backgroundColor: CustomColors.themeColor,
        ),

        AppData.user!.role_name=="Site Engineer"||AppData.user!.role_name=="Planning Engineer"?
        BottomNavigationBarItem(
          icon: Icon(Icons.mail_outlined,size: 24),
          label: 'My plans',
          backgroundColor: CustomColors.themeColor,
        ):AppData.user!.role_name=="Construction Manager"?
        BottomNavigationBarItem(
          icon: Icon(Icons.contactless_outlined,size: 24),
          label: 'Variance',
          backgroundColor: CustomColors.themeColor,
        ):BottomNavigationBarItem(
          icon: Icon(Icons.grading,size: 24),
          label: 'Actions',
          backgroundColor: CustomColors.themeColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined,size: 24),
          label: AppData.user!.role_name=="Planning Engineer"||AppData.user!.role_name=="Site Engineer"?'Update':'Plan',
          backgroundColor: CustomColors.themeColor,
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.person_outline,size: 24),
        //   label: 'Profile',
        //   backgroundColor: CustomColors.themeColor,
        // ),
      ],
    );
  }
}
