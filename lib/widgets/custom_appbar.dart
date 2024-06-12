import 'package:flutter/material.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';


class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  String title;

  CustomAppbar({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title,style: titilliumTitle.copyWith(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
      ),
        backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
