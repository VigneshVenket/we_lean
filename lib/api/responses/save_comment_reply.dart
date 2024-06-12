


import 'package:we_lean/utils/app_constants.dart';

import '../../models/feed_posts.dart';

class SaveCommentReplyResponse {
  String? status;
  String? message;
  CommentReply? data;
  int? code;

  SaveCommentReplyResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory SaveCommentReplyResponse.fromJson(Map<String, dynamic> json) {
    return SaveCommentReplyResponse(
      status: json['status'],
      message: json['message'],
      data: CommentReply.fromJson(json['data']),
      code: json['code'],
    );
  }

  SaveCommentReplyResponse.withError(String error){
    status=AppConstants.status_error;
    message=error;
    data=null;
    code=0;
  }
}
