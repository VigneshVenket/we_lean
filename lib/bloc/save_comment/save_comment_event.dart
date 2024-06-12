

import 'package:equatable/equatable.dart';

abstract class SaveCommentEvent {
  const SaveCommentEvent();

}

class SubmitComment extends SaveCommentEvent {
  final int userId;
  final int postId;
  final String comments;

  SubmitComment({
    required this.userId,
    required this.postId,
    required this.comments,
  });

}
