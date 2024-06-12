import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class CustomButtonSubmit extends StatefulWidget {

  final String title;
  final VoidCallback onPressed;

  CustomButtonSubmit({Key? key,required this.title,required this.onPressed}) : super(key: key);

  @override
  _CustomButtonSubmitState createState() => _CustomButtonSubmitState();
}

class _CustomButtonSubmitState extends State<CustomButtonSubmit> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height*0.06,
      width:MediaQuery.of(context).size.width*0.90,
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.themeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Text(widget.title,
            style: titilliumSemiBold),
        onPressed: widget.onPressed,
      ),
    );
  }
}