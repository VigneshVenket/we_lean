import 'package:flutter/material.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';


class CustomMessenger {
  static void showMessage(BuildContext context, String message,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message,style: titilliumRegular.copyWith(color: Colors.white)),
       backgroundColor: color
      ),
    );
  }
}




