


abstract class DiscussionPostDeleteEvent {}

class DeletePostEvent extends DiscussionPostDeleteEvent {
  final int postId;
  final int userId;

  DeletePostEvent(this.postId,this.userId);
}

class DeleteCommentEvent extends DiscussionPostDeleteEvent {
  final int commentId;
  final int userId;

  DeleteCommentEvent(this.commentId,this.userId);
}

class DeleteCommentReplyEvent extends DiscussionPostDeleteEvent {
  final int commentReplyId;
  final int userId;

  DeleteCommentReplyEvent(this.commentReplyId,this.userId);
}