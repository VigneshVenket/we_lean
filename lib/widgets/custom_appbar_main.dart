import 'package:flutter/material.dart';
import 'package:we_lean/screens/chat_list_screen.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';


class CustomAppbarMain extends StatelessWidget implements PreferredSizeWidget{
  String title;

  CustomAppbarMain({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: titilliumTitle.copyWith(color: Colors.black),),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: GestureDetector(
      //         onTap: (){CustomNavigation.push(context, ChatListScreen());},
      //         child: Icon(Icons.message,color: Colors.black,)),
      //   )
      // ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>  Size.fromHeight(kToolbarHeight);
}
