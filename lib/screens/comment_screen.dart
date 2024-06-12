import 'package:flutter/material.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_event.dart';
import 'package:we_lean/bloc/save_comment_reply/save_comment_reply_bloc.dart';
import 'package:we_lean/bloc/save_comment_reply/save_comment_reply_event.dart';
import 'package:we_lean/bloc/save_comment_reply/save_comment_reply_state.dart';
import 'package:we_lean/models/feed_posts.dart';
import 'package:we_lean/screens/main_screen.dart';
import 'package:we_lean/screens/posts_screen.dart';
import 'package:we_lean/utils/app_data.dart';
import 'package:we_lean/utils/styles.dart';
import 'package:we_lean/widgets/custom_appbar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/widgets/custom_route.dart';
import '../bloc/discusssion_post_delete/discussion_post_delete_bloc.dart';
import '../bloc/discusssion_post_delete/discussion_post_delete_state.dart';
import '../bloc/is_like_post/is_like_post_bloc.dart';
import '../models/comment_reply_data.dart';


import '../bloc/feed_post/feed_post_bloc.dart';
import '../bloc/feed_post/feed_post_event.dart';
import '../bloc/save_comment/save_comment_bloc.dart';
import '../repo/discussion_post_delete_repo.dart';
import '../repo/feed_post_repo.dart';
import '../repo/is_like_post_repo.dart';
import '../repo/save_comment_reply_repo.dart';
import '../repo/save_comment_repo.dart';
import '../utils/colors.dart';
import '../widgets/custom_messenger.dart';




class CommentScreen extends StatefulWidget {
  final List<Comment> commentList;

  const CommentScreen({required this.commentList, Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController replyController = TextEditingController();
  final FocusNode replyFocusNode = FocusNode();
  int? currentCommentId;



  String getTimeDifference(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    return timeago.format(dateTime, locale: 'en_short');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Comments",
      ),
      body:MultiBlocListener(
        listeners: [
          BlocListener<SaveCommentReplyBloc,SaveCommentReplyState>(
            listener: (context,state){
              if(state is SaveCommentReplySuccess){
                replyController.clear();

                final commentIndex = widget.commentList.indexWhere((comment) => comment.id == currentCommentId);
                if (commentIndex != -1) {
                  setState(() {
                    widget.commentList[commentIndex].commentReplies.add(state.commentReply);
                  });
                }

                // Navigator.pop(context);
                // CustomNavigation.push(context,
                //     MultiBlocProvider(
                //         providers: [
                //           BlocProvider(
                //             create:(BuildContext context) {
                //               return FeedPostsBloc(RealFeedPostsRepo());
                //             } ,
                //           ),
                //           BlocProvider(
                //             create:(BuildContext context) {
                //               return SaveCommentBloc(RealSaveCommentRepo());
                //             } ,
                //           ),
                //         ],
                //         child:PostsScreen()
                //     )
                // );
                // CustomNavigation.push(context,  MultiBlocProvider(
                //   providers: [
                //     BlocProvider(
                //       create: (BuildContext context) {
                //         return SaveCommentReplyBloc(RealSaveCommentReplyRepo());
                //       },),
                //   ],
                //   child: CommentScreen(commentList:widget.commentList) ,
                // ),);
              }
            },
          ),
          // BlocListener<DiscussionPostDeleteBloc,DiscussionPostDeleteState>(
          //   listener: (context,state){
          //     if(state is DiscussionPostDeleteSuccess){
          //       CustomMessenger.showMessage(context, state.status, Colors.green);
          //
          //     }else if(state is DiscussionPostDeleteFailure){
          //       CustomMessenger.showMessage(context,state.error, Colors.red);
          //     }
          //   },
          // ),
        ],
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.commentList.length,
                    itemBuilder: (context, index) {
                      return BlocListener<DiscussionPostDeleteBloc,DiscussionPostDeleteState>(
                        listener: (context,state){
                          if(state is DiscussionPostDeleteSuccess){
                            CustomNavigation.pushAndRemoveUntill(context, MainScreen());
                            // CustomNavigation.push(context,MultiBlocProvider(
                            //     providers: [
                            //       BlocProvider(
                            //         create:(BuildContext context) {
                            //           return FeedPostsBloc(RealFeedPostsRepo());
                            //         } ,
                            //       ),
                            //       BlocProvider(
                            //         create:(BuildContext context) {
                            //           return SaveCommentBloc(RealSaveCommentRepo());
                            //         } ,
                            //       ),
                            //       BlocProvider(
                            //         create:(BuildContext context) {
                            //           return LikePostBloc(likePostRepo: RealLikePostRepo());
                            //         } ,
                            //       ),
                            //       BlocProvider(
                            //         create:(BuildContext context) {
                            //           return DiscussionPostDeleteBloc(RealDiscussionPostDeleteRepo());
                            //         } ,
                            //       ),
                            //     ],
                            //     child:PostsScreen()
                            // ),);
                            // CustomNavigation.push(context,  MultiBlocProvider(
                            //   providers: [
                            //
                            //     BlocProvider(
                            //       create: (BuildContext context) {
                            //         return SaveCommentReplyBloc(RealSaveCommentReplyRepo());
                            //
                            //       },),
                            //
                            //     BlocProvider(
                            //       create: (BuildContext context) {
                            //         return DiscussionPostDeleteBloc(RealDiscussionPostDeleteRepo());
                            //
                            //       },),
                            //   ],
                            //   child: CommentScreen(commentList: widget.commentList) ,
                            // ),);
                            CustomMessenger.showMessage(context, state.status, Colors.green);

                          }else if(state is DiscussionPostDeleteFailure){
                            CustomMessenger.showMessage(context,state.error, Colors.red);
                          }
                        },
                        child:CommentWidget(
                          comment: widget.commentList[index],
                          isExpanded:false,
                          replyFocusnode: replyFocusNode,
                          onReplyTap: (int commentId) { // Add this line
                            setState(() {
                              currentCommentId = commentId; // Store the current comment ID
                            });
                          },
                        ) ,

                      );

                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(240, 240, 240, 1)),
                        child: TextField(
                          controller: replyController,
                          cursorColor: CustomColors.themeColor,
                          focusNode: replyFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: titilliumBoldRegular,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(color: CustomColors.themeColorOpac),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          BlocProvider.of<SaveCommentReplyBloc>(context).add(SubmitCommentReply(
                              userId: AppData.user!.id!, commentId: currentCommentId!, comments:replyController.text));
                          // Add your comment submission logic here
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) ,
      )

    );
  }
}


class CommentWidget extends StatefulWidget {

  final Comment comment;
  bool isExpanded;
  final FocusNode replyFocusnode;
  final Function(int) onReplyTap;

  CommentWidget({required this.comment, required this.isExpanded,required this.replyFocusnode,required this.onReplyTap});

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  String getTimeDifference(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    return timeago.format(dateTime, locale: 'en_short');
  }

  bool tappedReply=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors.themeColorOpac),
              child: Icon(Icons.person, size: 24, color: Colors.white),
            ),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.comment.user!.name, style: titilliumBoldRegular),
                      Text(getTimeDifference(widget.comment.createdAt) =="now"?'${getTimeDifference(widget.comment.createdAt)}':
                      '${getTimeDifference(widget.comment.createdAt)} ago',
                          style: titilliumSemiRegular.copyWith(color: Colors.grey)),
                    AppData.user!.id==widget.comment.user!.id?
                    GestureDetector(
                      onTap: (){
                        BlocProvider.of<DiscussionPostDeleteBloc>(context).add(DeleteCommentEvent(widget.comment.id, AppData.user!.id!));
                      },
                          child: Icon(Icons.delete_outline,size: 20,color: CustomColors.themeColor,)):Container()
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(widget.comment.comments, style: titilliumSemiRegular),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      widget.replyFocusnode.requestFocus();
                      widget.onReplyTap(widget.comment.id);
                    },
                    child: Text(
                      "Reply",
                      style: titilliumQuarBoldRegular.copyWith(color: Colors.grey),
                    ),
                  ),
                  widget.comment.commentReplies.isNotEmpty?
                  Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          setState(() {
                            widget.isExpanded=!widget.isExpanded;
                          });

                        },
                        child: Text(
                          widget.isExpanded ? 'Hide replies' : 'View all replies',
                          style: titilliumQuarBoldRegular.copyWith(color: CustomColors.themeColor)
                        ),
                      ),
                    ],
                  ):Container(),
                  if (widget.isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: widget.comment.commentReplies.map((reply) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: CustomColors.themeColorOpac),
                                child: Icon(Icons.person, size: 18, color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(reply.user!.name, style:titilliumBoldRegular),
                                        SizedBox(width: 5),
                                        Text(getTimeDifference(widget.comment.createdAt) =="now"?'${getTimeDifference(widget.comment.createdAt)}':
                                        '${getTimeDifference(widget.comment.createdAt)} ago',
                                            style: titilliumSemiRegular.copyWith(color: Colors.grey)),
                                         AppData.user!.id==reply.user!.id?
                                         GestureDetector(
                                           onTap: (){
                                             BlocProvider.of<DiscussionPostDeleteBloc>(context).add(DeleteCommentReplyEvent(reply.id, AppData.user!.id!));
                                           },
                                            child: Icon(Icons.delete_outline,size: 20,color: CustomColors.themeColor,)):Container()

                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(reply.comments, style: titilliumSemiRegular),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}





