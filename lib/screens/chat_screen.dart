import 'package:flutter/material.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, text);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      width: MediaQuery.of(context).size.width*0.95,
      height: MediaQuery.of(context).size.height*0.07,
      decoration: BoxDecoration(
        color: Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                cursorColor: CustomColors.themeColor,
                decoration: InputDecoration.collapsed(
                  hintText: 'Message...',
                  hintStyle: titilliumBoldRegular.copyWith(color: Colors.grey[700])
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,color: Colors.grey[700]),
            onPressed: () {
              _handleSubmitted(_textController.text);
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey
                ),
                child: Icon(Icons.person,size: 20,color: Colors.white,)),
            SizedBox(width: 10,),
            Text("Rajesh",style: titilliumBold.copyWith(color: Colors.black),),
          ],
        ),
        backgroundColor: Color.fromRGBO(240, 240, 240,1),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 18,color: Colors.black,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_messages[index],style: titilliumRegular,),
                  );
                },
              ),
            ),
            Divider(height: 1.0),
            _buildTextComposer(),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}
