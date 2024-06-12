import 'package:flutter/material.dart';
import 'package:we_lean/screens/account_created_screen.dart';
import 'package:we_lean/screens/login_screen.dart';
import 'package:we_lean/widgets/custom_route.dart';
import '../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_messenger.dart';
import '../widgets/custom_textformfield.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  TextEditingController _nameController=TextEditingController();
  TextEditingController _employeeIdController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();
  TextEditingController _roleController=TextEditingController();

  bool isPasswordEnabled=true;
  bool isConfirmPasswordEnabled=true;

  List<String>    _role=["Engineer","Manager","Support"];
  String? selectedRole;


  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                width: 110,
                height: 110,
                child: Image.asset("assets/images/We Lean New Logo 16-08-2023.png",fit: BoxFit.fill,),
              ),
              SizedBox(height: 40,),
              Padding(
                padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.74),
                child: Text("SignUp",style:  titilliumTitle,),
              ),
              SizedBox(height: 20,),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: CustomTextFormField(
                    controller: _nameController!,
                    obscureText: false,
                    hintText: "Name",
                    icon: Icons.person,
                  )
              ),
              SizedBox(height: 10,),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: CustomTextFormField(
                    controller: _employeeIdController,
                    obscureText: false,
                    hintText: "Employee Id",
                    icon: Icons.card_membership,
                  )
              ),
              SizedBox(height: 10,),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: CustomTextFormField(
                    controller: _emailController!,
                    obscureText: false,
                    hintText: "Email",
                    icon: Icons.mail,
                  )
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: 'Role',
                    hintStyle: titilliumBoldRegular,
                    prefixIcon: Icon(Icons.engineering,
                      size: 16,
                      color:Color.fromRGBO(0, 0, 0, 1) ,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                    border: InputBorder.none,
                  ),
                  value: selectedRole,
                  dropdownColor: Color.fromRGBO(240, 240, 240, 1),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                  items: _role.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role, style: titilliumRegular),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 10,),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: CustomTextFormField(
                    obscureText: isPasswordEnabled,
                    controller: _passwordController!,
                    hintText: "Password",
                    icon: Icons.lock,
                  )
              ),
              SizedBox(height: 10,),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: MediaQuery.of(context).size.height*0.06,
                  child: CustomTextFormField(
                    obscureText: isConfirmPasswordEnabled,
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    icon: Icons.lock,
                  )
              ),
              SizedBox(height: 10,),
              CustomButton(
                title: "Sign Up",
                onPressed: () {
                  if(_nameController.text.isNotEmpty&&_passwordController!.text.isNotEmpty&&_confirmPasswordController.text.isNotEmpty
                     &&_employeeIdController.text.isNotEmpty&&_emailController.text.isNotEmpty&&selectedRole!.isNotEmpty
                  ){
                    CustomNavigation.pushReplacement(context, AccountCreatedScreen());
                    // CustomMessenger.showMessage(context,"Registered Successfully", Colors.green);
                  }
                  else{
                    CustomMessenger.showMessage(context,"Input fields should not be empty", Colors.red);
                  }
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?",style: titilliumRegular.copyWith(
                      color: Color.fromRGBO(0, 0, 0, 1))),
                  TextButton(onPressed: (){
                    CustomNavigation.push(context, LoginScreen());
                  }, child: Text("SignIn",
                    style: titilliumBoldRegular.copyWith(
                        color: Color.fromRGBO(0, 0, 0, 1)
                    ) ,
                  ))
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
