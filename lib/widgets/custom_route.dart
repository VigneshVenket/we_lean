
import 'package:flutter/material.dart';


class CustomNavigation{

  static void push(BuildContext context,Widget widget){
   Navigator.of(context).push(MaterialPageRoute(builder: (c)=>widget));
  }

  static void pushReplacement(BuildContext context,Widget widget){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c)=>widget));
  }

  static void pushAndRemoveUntill(BuildContext context,Widget widget){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c)=>widget), (route) => false);
  }

}