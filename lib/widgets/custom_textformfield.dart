import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class CustomTextFormField extends StatefulWidget {

  TextEditingController controller;
  String hintText;
  IconData icon;
  bool obscureText;


  CustomTextFormField({Key? key,required this.controller,required this.hintText,required this.icon,required this.obscureText}) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      cursorColor:  CustomColors.themeColor,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: 0),
          fillColor:Color.fromRGBO(240, 240, 240, 1),
          filled: true,
          hintText:widget.hintText,
          hintStyle: titilliumBoldRegular,
          prefixIcon: Icon(
            widget.icon,
            size: 16,
            color:Color.fromRGBO(0, 0, 0, 1) ,
          )),

    );
  }
}
