import 'package:flutter/material.dart';
import 'package:we_lean/widgets/custom_appbar.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';



class ConstraintsTagListScreen extends StatefulWidget {
  const ConstraintsTagListScreen({Key? key}) : super(key: key);

  @override
  _ConstraintsTagListScreenState createState() => _ConstraintsTagListScreenState();
}

class _ConstraintsTagListScreenState extends State<ConstraintsTagListScreen> {

  List<ConstraintTag>  _constraintTagList=[
    ConstraintTag(
      weekNo: 13,
      from: "25-03-24",
      to:"31-03-24",
    ),
    ConstraintTag(
      weekNo: 14,
      from: "01-04-24",
      to:"07-04-24",
    ),
    ConstraintTag(
      weekNo: 15,
      from: "08-04-24",
      to:"14-04-24",
    ),
    ConstraintTag(
      weekNo: 16,
      from: "15-04-24",
      to:"21-04-24",
    ),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Constraints Tag List",
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _constraintTagList.length,
                itemBuilder: (context,index){
                  return  Column(
                    children: [
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.themeColorOpac
                            ),
                            child: Icon(Icons.how_to_reg,color: Colors.white,size: 25,)),

                        title: Text('Week ${_constraintTagList[index].weekNo}',style: titilliumBoldRegular,),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('From : ${_constraintTagList[index].from}',style: titilliumRegular,),
                                Text('To : ${_constraintTagList[index].to}',style: titilliumRegular,),
                                Icon(Icons.arrow_forward_ios,color: Colors.black,size: 18,)
                              ],
                            ),
                            // Text('Activities : ${weekData.length}',style: titilliumRegular,)
                          ],
                        ),
                        onTap: (){

                        },
                      ),
                      Divider()
                    ],
                  );
                },

              ),
            ),
          ),
        ],
      ),
    );
  }
}



class ConstraintTag{

  int? weekNo;
  String? from;
  String? to;

  ConstraintTag({this.weekNo,this.from,this.to});

}