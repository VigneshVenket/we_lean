import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_bloc.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_event.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_state.dart';
import 'package:we_lean/bloc/feed_post/feed_post_bloc.dart';
import 'package:we_lean/bloc/feed_post/feed_post_event.dart';
import 'package:we_lean/bloc/feed_post/feed_post_state.dart';
import 'package:we_lean/bloc/is_like_post/is_like_post_bloc.dart';
import 'package:we_lean/bloc/save_comment/save_comment_bloc.dart';
import 'package:we_lean/bloc/save_comment/save_comment_event.dart';
import 'package:we_lean/bloc/save_comment/save_comment_state.dart';
import 'package:we_lean/bloc/save_comment_reply/save_comment_reply_bloc.dart';
import 'package:we_lean/repo/discussion_post_delete_repo.dart';
import 'package:we_lean/repo/feed_post_repo.dart';
import 'package:we_lean/repo/save_comment_reply_repo.dart';
import 'package:we_lean/screens/comment_screen.dart';
import 'package:we_lean/utils/app_config.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/colors.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar_main.dart';
import 'package:we_lean/widgets/custom_messenger.dart';
import 'package:we_lean/widgets/custom_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../bloc/is_like_post/is_like_post_event.dart';
import '../bloc/is_like_post/is_like_post_state.dart';
import '../bloc/posts/post_bloc.dart';
import '../repo/posts_repo.dart';
import 'add_post_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {


  List<bool> isLike=[];

  bool isLikeUpdated=false;

  void addComment() {
    setState(() {

    });
  }

  TextEditingController _commentController=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<FeedPostsBloc>(context).add(LoadFeedPosts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Posts",style: titilliumTitle.copyWith(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:GestureDetector(
                onTap: (){CustomNavigation.push(context,  BlocProvider(
                  create: (BuildContext context) {
                    return PostBloc(RealPostsRepo());
                  },
                  child:AddPostScreen(),
                ),);},
                child: Icon(Icons.add_a_photo_outlined,color: Colors.black,size: 26,)
                // Container(
                //   width: 40,
                //   height: 40,
                //   decoration: BoxDecoration(
                //       color:CustomColors.themeColorOpac,
                //       borderRadius: BorderRadius.circular(10)
                //   ),
                //   child:Icon(Icons.add_circle_outline,color: Colors.white,) ,
                // ),
            )
          )],
      ),
      body:MultiBlocListener(
        listeners: [
          BlocListener<SaveCommentBloc,SaveCommentState>(
            listener: (context,state){
                if(state is SaveCommentSuccess){
                  _commentController.clear();
                  BlocProvider.of<FeedPostsBloc>(context).add(LoadFeedPosts());
                }
            },
          ),
          BlocListener<DiscussionPostDeleteBloc,DiscussionPostDeleteState>(
            listener: (context,state){
              if(state is DiscussionPostDeleteSuccess){
                CustomMessenger.showMessage(context, state.status, Colors.green);
                BlocProvider.of<FeedPostsBloc>(context).add(LoadFeedPosts());
              }else if(state is DiscussionPostDeleteFailure){
                CustomMessenger.showMessage(context,state.error, Colors.red);
              }
            },
          ),
          // BlocListener<LikePostBloc,LikePostState>(
          //   listener: (context,state){
          //
          //   },
          // )
        ],
        child: BlocBuilder<FeedPostsBloc,FeedPostsState>(
          builder: (context,state){
            if(state is FeedPostsLoaded){
               if(state.posts.isNotEmpty){
                 List reversedPostDataList=state.posts.reversed.toList();
                 isLike = List<bool>.generate(reversedPostDataList.length, (index) => false);
                 return ListView.builder(
                     itemCount: reversedPostDataList.length,
                     itemBuilder: (context,index){
                       return  Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             // Post header
                             Row(
                               children: [
                                 Container(
                                     width: 40,
                                     height: 40,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(20),
                                         color: CustomColors.themeColorOpac
                                     ),
                                     child: Icon(Icons.person,size: 24,color: Colors.white,)),
                                 SizedBox(width: 8.0),
                                 Text(
                                   reversedPostDataList[index].user!.name,
                                   style: titilliumBoldRegular,
                                 ),
                               ],
                             ),
                             SizedBox(height: 10,),

                             BlocConsumer<LikePostBloc,LikePostState>(
                               listener: (context,state){
                                 if(state is LikePostSuccess){
                                   // print("Hello");
                                   BlocProvider.of<FeedPostsBloc>(context).add(LoadFeedPosts());
                                   // isLike[index]=true;
                                   // print(index);
                                   // print( isLike[index]);
                                 }
                               },
                               builder: (context,state){
                                 return Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     reversedPostDataList[index].postImages.isNotEmpty?
                                     GestureDetector(
                                       onDoubleTap: (){
                                         // BlocProvider.of<LikePostBloc>(context).add(LikePost(postId: reversedPostDataList[index].id));
                                       },
                                       child: Container(
                                         width: MediaQuery.of(context).size.width*0.95,
                                         height: MediaQuery.of(context).size.height*0.32,
                                         child: Image.network(
                                           "${AppConfig.plan_url}/${reversedPostDataList[index].postImages.first}",
                                           fit: BoxFit.fill,
                                         ),
                                       ),
                                     ):Container(
                                       width: MediaQuery.of(context).size.width*0.95,
                                       height: MediaQuery.of(context).size.height*0.32,
                                     ),
                                     // SizedBox(height: 10,),
                                     // Container(
                                     //   width: MediaQuery.of(context).size.width*0.15,
                                     //   child: Row(
                                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     //     children: [
                                     //       isLike[index]?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
                                     //       GestureDetector(
                                     //           onTap: (){CustomNavigation.push(context,CommentScreen(commentList:reversedPostDataList[index].comments,));},
                                     //           child: Icon(Icons.chat_bubble_outline)),
                                     //       // Icon(Icons.send),
                                     //     ],
                                     //   ),
                                     // ),
                                     // SizedBox(height: 10,),
                                     // Text(
                                     //   reversedPostDataList[index].isLike.toString(),
                                     //   style: TextStyle(
                                     //     fontWeight: FontWeight.bold,
                                     //   ),
                                     // ),
                                     // SizedBox(height: 10,),
                                   ],
                                 );
                               },
                             ),
                             SizedBox(height: 10,),
                             Row(
                               children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.898,
                                  child: Row(
                                    children: [
                                      Text( reversedPostDataList[index].user!.name,style: titilliumSemiBoldRegular,),
                                      SizedBox(width: 5,),
                                      Text("${getTimeDifference(reversedPostDataList[index].createdAt)} .",style: titilliumSemiBoldRegular.copyWith(color: Colors.grey),),
                                      Text(reversedPostDataList[index].description!,style: titilliumSemiRegular,),
                                    ],
                                  ),
                                ),
                                 AppData.user!.id==reversedPostDataList[index].user!.id?
                                GestureDetector(
                                   onTap: (){
                                     BlocProvider.of<DiscussionPostDeleteBloc>(context).add(DeletePostEvent(reversedPostDataList[index].id, AppData.user!.id!));
                                   },
                                   child: Icon(Icons.delete_outline,size: 20,color: CustomColors.themeColor,),
                                 ):Container()
                               ],
                             ),
                             SizedBox(height: 10,),
                             reversedPostDataList[index].comments.length!=0?
                             GestureDetector(
                                 onTap:(){

                                   CustomNavigation.push(context,  MultiBlocProvider(
                                     providers: [

                                       BlocProvider(
                                         create: (BuildContext context) {
                                           return SaveCommentReplyBloc(RealSaveCommentReplyRepo());

                                         },),

                                       BlocProvider(
                                         create: (BuildContext context) {
                                           return DiscussionPostDeleteBloc(RealDiscussionPostDeleteRepo());

                                         },),
                                     ],
                                     child: CommentScreen(commentList: reversedPostDataList[index].comments) ,
                                   ),);

                                 } ,
                                 child: Text("View all ${reversedPostDataList[index].comments.length} comments",style: titilliumRegular,)):Container(),
                             SizedBox(height: 10,),
                             Row(
                               children: [
                                 Expanded(
                                   child:
                                   Container(
                                     width: MediaQuery.of(context).size.width,
                                     height: MediaQuery.of(context).size.height*0.05,
                                     decoration: BoxDecoration(
                                         color: Color.fromRGBO(240, 240, 240, 1)
                                     ),
                                     child: TextField(
                                       controller: _commentController,
                                       cursorColor: CustomColors.themeColor,
                                       decoration: InputDecoration(
                                         hintText: 'Add a comment...',
                                         border: InputBorder.none,
                                       ),
                                       // onSubmitted: (String value) {
                                       //   addComment(value);
                                       //
                                       // },
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 8.0),
                                 Container(
                                   width: MediaQuery.of(context).size.width*0.1,
                                   height: MediaQuery.of(context).size.height*0.05,
                                   decoration: BoxDecoration(
                                       color: CustomColors.themeColorOpac
                                   ),
                                   child: IconButton(
                                     icon: Icon(Icons.send,color: Colors.white,),
                                     onPressed: () {
                                       BlocProvider.of<SaveCommentBloc>(context).add(SubmitComment(
                                           userId: AppData.user!.id!, postId: reversedPostDataList[index].id, comments: _commentController.text));
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       );
                     });
               }else{
                 return Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height,
                   // decoration: BoxDecoration(
                   // borderRadius: BorderRadius.circular(10),
                   // color: Color.fromRGBO(240, 240, 240, 1)
                   // ),
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Column(
                       children: [
                         SizedBox(height:50,),
                         Container(
                           width: MediaQuery.of(context).size.width*0.6,
                           height: MediaQuery.of(context).size.height*0.5,
                           decoration: BoxDecoration(
                               color: Color.fromRGBO(240, 240, 240, 1),
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Image.asset("assets/images/no plan for day.jpg",fit: BoxFit.cover,),
                         ),
                         SizedBox(height: 10,),
                         Center(child: Text("No posts available",style: titilliumBold,)),
                       ],
                     ),
                   ),
                 );
               }


            }else if(state is FeedPostsError){
              return Container(
                child: Text(state.error),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(
                  color: CustomColors.themeColor,
                ),
              );
            }
          },
        ) ,

      )




    );


  }

  Widget CustomListProfileTile(String title,IconData icon,){
    return    Container(
      child: ListTile(
        leading:
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color:CustomColors.themeColorOpac,
              borderRadius: BorderRadius.circular(10)
          ),
          child:Icon(icon,color: Colors.white,) ,
        ),
        title: Text(title,style: titilliumSemiBold,),
        trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14,),
      ),
    );
  }

  String getTimeDifference(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    return timeago.format(dateTime, locale: 'en_short');
  }
}

class Posts{
  String? name;
  String? imageUrl;
  String? likes;

  Posts(this.name,this.imageUrl,this.likes );


}



