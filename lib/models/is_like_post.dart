

// class PostData {
//   final int id;
//   final int userId;
//   final String description;
//   final List<String> postImages;
//   final int isLike;
//   final String createdAt;
//   final String updatedAt;
//
//   PostData({
//     required this.id,
//     required this.userId,
//     required this.description,
//     required this.postImages,
//     required this.isLike,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory PostData.fromJson(Map<String, dynamic> json) {
//     return PostData(
//       id: json['id'],
//       userId: json['user_id'],
//       description: json['description'],
//       postImages: List<String>.from(json['post_images']),
//       isLike: json['is_like'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }


import 'dart:convert';

class PostData {
  final int id;
  final int userId;
  final String description;
  final List<String> postImages;
  final int isLike;
  final String createdAt;
  final String updatedAt;

  PostData({
    required this.id,
    required this.userId,
    required this.description,
    required this.postImages,
    required this.isLike,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      id: json['id'],
      userId: json['user_id'],
      description: json['description'],
      postImages: List<String>.from(jsonDecode(json['post_images'])),
      isLike: json['is_like'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


