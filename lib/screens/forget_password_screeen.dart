import 'package:flutter/material.dart';
import 'package:we_lean/screens/reset_password_screen.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:we_lean/widgets/custom_textformfield.dart';


class ForgetPasswordScreen extends StatefulWidget {

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _emailController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
           title: "Forget Password",
         ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Enter the email associated with your account and "
                  "we’ll send an email with instructions to reset your password",
                textAlign: TextAlign.center,
                style:titilliumRegular),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.07,
              child: CustomTextFormField(
                  controller: _emailController,
                  obscureText: false,
                  hintText: "Email",
                  icon: Icons.email),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(title: "Send email", onPressed: (){
              CustomNavigation.push(context, ResetPasswordScreen());
            })
        ],
      ),
      ),

    );
  }
}
