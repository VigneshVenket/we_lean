

class CommentReply {
  final int id;
  final String userId;
  final String commentId;
  final String comments;
  final String createdAt;
  final String updatedAt;

  CommentReply({
    required this.id,
    required this.userId,
    required this.commentId,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentReply.fromJson(Map<String, dynamic> json) {
    return CommentReply(
      id: json['id'],
      userId: json['user_id'],
      commentId: json['comment_id'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
