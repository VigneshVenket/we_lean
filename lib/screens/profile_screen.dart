import 'package:flutter/material.dart';
import 'package:we_lean/screens/add_post_screen.dart';
import 'package:we_lean/screens/change_password_screen.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_button.dart';
import 'package:we_lean/widgets/custom_button_main.dart';
import 'package:we_lean/widgets/custom_button_submit.dart';
import 'package:we_lean/widgets/custom_route.dart';

import '../utils/colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  List<String>   profileImgUrls=[
    "assets/images/posts1_profile_img.jpeg",
    "assets/images/posts2_profile_img.jpg",
    "assets/images/posts3_profile_img.jpg",
    "assets/images/posts4_profile_img.jpg",
    "assets/images/posts5_profile_img.jpg",
    "assets/images/posts6_profile_img.jpg",
    "assets/images/posts1_profile_img.jpeg",
    "assets/images/posts2_profile_img.jpg",
    "assets/images/posts3_profile_img.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarMain(
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
                 SizedBox(height: 10),
                 Center(
                   child:
                   Container(
                     width: 100,
                     height: 100,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(60),
                       border: Border.all(color: Colors.grey),
                       color: Colors.grey
                    ),
                     child: Icon(Icons.person_sharp,size: 60,color: Colors.white,),
                   ),
                 ),
              SizedBox(height: 10,),
              ProfileDataContainer("Rajesh",Icons.person),
              SizedBox(height: 10,),
              ProfileDataContainer("Rajeshplantoday.com",Icons.mail),
              SizedBox(height: 10,),
              ProfileDataContainer("Junior Engineer",Icons.engineering),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.42,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: CustomSubmitMain(
                        title: "Add Post",
                        onPressed: (){
                          CustomNavigation.push(context,AddPostScreen());
                        },
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      child: CustomSubmitMain(
                        title: "Change Password",
                        onPressed: (){
                          CustomNavigation.push(context,ChangePasswordScreen());
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              // Text("Your Posts",style: titilliumSemiBold,),
              Center(child: Icon(Icons.inbox_rounded,size: 30,)),
              Divider(thickness:0.2 ,color: Colors.black,),
              SizedBox(height: 10,),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: profileImgUrls.length, // Example count
                itemBuilder: (context,index) {
                  return Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    padding: EdgeInsets.all(1),
                    child: Image.asset(profileImgUrls[index],fit: BoxFit.fill,),
                  );
                },
              ),
                ],
          ),
        ),
      ),
    );
  }

  Widget ProfileDataContainer(String text,IconData icon){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(240, 240, 240, 1)
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Icon(icon),
          SizedBox(width: 50,),
          Text(text,style: titilliumRegular.copyWith(color: Colors.black)),
        ],
      )
      );
  }



}
