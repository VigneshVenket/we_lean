


import 'package:equatable/equatable.dart';

import '../../models/feed_posts.dart';

abstract class SaveCommentReplyState {
  const SaveCommentReplyState();

}

class SaveCommentReplyInitial extends SaveCommentReplyState {}

class SaveCommentReplyLoading extends SaveCommentReplyState {}

class SaveCommentReplySuccess extends SaveCommentReplyState {
  final CommentReply commentReply;

  const SaveCommentReplySuccess(this.commentReply);

}

class SaveCommentReplyFailure extends SaveCommentReplyState {
  final String error;

  const SaveCommentReplyFailure(this.error);


}
