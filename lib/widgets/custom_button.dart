import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';


class CustomButton extends StatefulWidget {

  final String title;
  final VoidCallback onPressed;

  CustomButton({Key? key,required this.title,required this.onPressed}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height*0.06,
      width:MediaQuery.of(context).size.width*0.95,
      child: ElevatedButton(
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
