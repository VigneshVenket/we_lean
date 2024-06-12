import 'package:we_lean/utils/app_constants.dart';

import '../../models/save_comment_data.dart';

class SaveCommentResponse {
  String ?status;
  String ?message;
  Comment ?data;
  int ?code;

  SaveCommentResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory SaveCommentResponse.fromJson(Map<String, dynamic> json) {
    return SaveCommentResponse(
      status: json['status'],
      message: json['message'],
      data: Comment.fromJson(json['data']),
      code: json['code'],
    );
  }

  SaveCommentResponse.withError(String error){
    status=AppConstants.status_error;
    message=error;
    data=null;
    code=0;
  }
}
