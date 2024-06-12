
import 'dart:convert';

class Post {
  final int id;
  final int? userId;
  final String? description;
  final List<String> postImages;
  final int isLike;
  final String createdAt;
  final String updatedAt;
  final User? user;
  final List<Comment> comments;

  Post({
    required this.id,
    this.userId,
    this.description,
    required this.postImages,
    required this.isLike,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      description: json['description'],
      postImages: List<String>.from(jsonDecode(json['post_images'])),
      isLike: json['is_like'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      comments: json['comments'] != null
          ? (json['comments'] as List).map((i) => Comment.fromJson(i)).toList()
          : [],
    );
  }
}



class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}


class Comment {
  final int id;
  final int postId;
  final int userId;
  final String comments;
  final String createdAt;
  final String updatedAt;
  final User? user;
  final List<CommentReply> commentReplies;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    required this.commentReplies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      commentReplies: json['comment_replies'] != null
          ? (json['comment_replies'] as List)
          .map((i) => CommentReply.fromJson(i))
          .toList()
          : [],
    );
  }
}



class CommentReply {
  final int id;
  final int commentId;
  final User? user;
  final String comments;
  final String createdAt;
  final String updatedAt;

  CommentReply({
    required this.id,
    required this.commentId,
    required this.user,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentReply.fromJson(Map<String, dynamic> json) {
    return CommentReply(
      id: json['id'],
      commentId: json['comment_id'],
      user :json['user'] != null ? User.fromJson(json['user']) : null,
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
