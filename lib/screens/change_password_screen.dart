import 'package:flutter/material.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_textformfield.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppbar(
        title: "Change Password",
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.07,
              child: CustomTextFormField(
                controller: _passwordController,
                icon: Icons.lock,
                obscureText: true,
                hintText: "Password",
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.07,
              child: CustomTextFormField(
                controller: _confirmPasswordController,
                icon: Icons.lock,
                obscureText: true,
                hintText: "Confirm Password",
              ),
            ),
          ),
          SizedBox(height: 10,),
          CustomButtonSubmit(title: "Update Changes", onPressed: (){})
        ],
      ),
    );
  }
}
