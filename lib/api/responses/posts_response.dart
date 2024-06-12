

import 'package:we_lean/utils/app_constants.dart';

import '../../models/posts_model.dart';

class PostResponse {
   String? status;
  String? message;
  Post? data;
  int? code;

  PostResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

   factory PostResponse.fromJson(Map<String, dynamic>? json) {
     if (json == null) {
       throw ArgumentError('PostResponse.fromJson received null');
     }

     return PostResponse(
       status: json['status'] ?? 'Unknown',
       message: json['message'] ?? 'No message',
       data: Post.fromJson(json['data']),
       code: json['code'] ?? 0,
     );
   }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'code': code,
    };
  }

  PostResponse.withError(String error){
    status=AppConstants.status_error;
    message=error;
    data=null;
    code=0;
  }
}
