import 'package:flutter/material.dart';
import 'package:we_lean/utils/colors.dart';

import '../utils/styles.dart';


class CustomSubmitMain extends StatefulWidget {
  final String ?title;
  final VoidCallback ?onPressed;

  const CustomSubmitMain({Key? key,this.title,this.onPressed}) : super(key: key);

  @override
  _CustomSubmitMainState createState() => _CustomSubmitMainState();
}

class _CustomSubmitMainState extends State<CustomSubmitMain> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: BorderSide(
              color:CustomColors.themeColor
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      child: Text(widget.title!,
          style: titilliumSemiBold.copyWith(color: CustomColors.themeColor)),
      onPressed: widget.onPressed,
    );
  }
}
