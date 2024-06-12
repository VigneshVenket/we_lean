


import 'dart:convert';

class Post {
  final int userId;
  final String description;
  final List<String> postImages;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Post({
    required this.userId,
    required this.description,
    required this.postImages,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['user_id'],
      description: json['description'],
      postImages: List<String>.from(jsonDecode(json['post_images'])),
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'description': description,
      'post_images': jsonEncode(postImages),
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
