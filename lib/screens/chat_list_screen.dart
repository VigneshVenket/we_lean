import 'package:flutter/material.dart';
import 'package:we_lean/screens/chat_screen.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:we_lean/widgets/custom_route.dart';




class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {


  List _userChatDetails=[
    UserChatDetails("Sathish", "Today", "Task Completed"),
    UserChatDetails("Saravanan", "Today", "Task not completed"),
    UserChatDetails("Ramesh", "Today", "Tmrw leave"),
    UserChatDetails("Ravi", "Yesterday", "Task Completed"),
    UserChatDetails("Santhosh", "Yesterday", "Tmrw leave"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Messages",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onFieldSubmitted: (value) {

                },

                textInputAction: TextInputAction.search,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: CustomColors.themeColor,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.search,color: Colors.grey[700],),
                  fillColor: Color.fromRGBO(240, 240, 240, 1),
                  hintStyle: titilliumRegular.copyWith(color: Colors.grey[700])
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _userChatDetails.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:GestureDetector(
                      onTap: (){CustomNavigation.push(context, ChatScreen());},
                      child: Row(
                        children: [
                          Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey
                              ),
                              child: Icon(Icons.person,size: 30,color: Colors.white,)),
                          SizedBox(width: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text(_userChatDetails[index].name,style: titilliumSemiBold,),
                                   SizedBox(height: 5,),
                                   Text(_userChatDetails[index].lastText,style: titilliumRegular,)
                              ],
                            ),
                          ),
                          Text(_userChatDetails[index].time,style: titilliumRegular,)
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}


class UserChatDetails{
  String ?name;
  String ?time;
  String ?lastText;

  UserChatDetails(this.name,this.time,this.lastText);

}
