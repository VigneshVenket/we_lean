

import 'package:equatable/equatable.dart';

abstract class SaveCommentReplyEvent {
  const SaveCommentReplyEvent();


}

class SubmitCommentReply extends SaveCommentReplyEvent {
  final int userId;
  final int commentId;
  final String comments;

  const SubmitCommentReply({
    required this.userId,
    required this.commentId,
    required this.comments,
  });

}
