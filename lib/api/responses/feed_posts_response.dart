


import 'package:we_lean/utils/app_constants.dart';

import '../../models/feed_posts.dart';

class FeedPostsResponse {
  String? status;
  List<Post>? data;
  int? code;

  FeedPostsResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory FeedPostsResponse.fromJson(Map<String, dynamic> json) {
    return FeedPostsResponse(
      status: json['status'],
      data: (json['data'] as List).map((i) => Post.fromJson(i)).toList(),
      code: json['code'],
    );
  }

  FeedPostsResponse.withError(String error){
    status=AppConstants.status_error;
    data=null;
    code=0;
  }

}
