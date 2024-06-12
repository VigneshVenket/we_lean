

class Comment {
  final int id;
  final User ?user;
  final int postId;
  final String comments;
  final String createdAt;
  final String updatedAt;

  Comment({
    required this.id,
    required this.user,
    required this.postId,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      postId: json['post_id'],
      comments: json['comments'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
