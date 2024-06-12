import 'package:flutter/material.dart';
import 'package:we_lean/widgets/custom_textformfield.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';


class ResetPasswordScreen extends StatefulWidget {

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();

  bool isPasswordEnabled=true;
  bool isConfrimPasswordEnabled=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Reset Password",
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.07,
              child: CustomTextFormField(
                  controller: _passwordController,
                  obscureText: isPasswordEnabled,
                  hintText: "Password",
                  icon: Icons.lock),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.07,
              child: CustomTextFormField(
                  controller: _confirmPasswordController,
                  obscureText: isPasswordEnabled,
                  hintText: "Confirm Password",
                  icon: Icons.lock),
            ),
            SizedBox(
              height: 15,
            ),
            CustomButton(title: "Update password", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
