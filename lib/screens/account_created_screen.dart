import 'package:flutter/material.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_route.dart';


class AccountCreatedScreen extends StatefulWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

  @override
  _AccountCreatedScreenState createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.18,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.5,
                child: Image.asset("assets/images/account_created_bg.jpg",fit: BoxFit.fill,),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Text("Account Created",style: titilliumTitle,),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Text("Let's build the future of transportation together",style: titilliumRegular,),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            CustomButton(title: "Get Started", onPressed: (){
              CustomNavigation.pushReplacement(context, MainScreen());
            })
          ],
        ),
      ),
    );
  }
}
