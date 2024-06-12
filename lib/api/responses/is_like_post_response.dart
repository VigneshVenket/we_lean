
import 'package:we_lean/utils/app_constants.dart';

import '../../models/is_like_post.dart';

// class LikePostResponse {
//   String ?status;
//   Post? data;
//   int ?code;
//
//   LikePostResponse({
//     required this.status,
//     required this.data,
//     required this.code,
//   });
//
//   factory LikePostResponse.fromJson(Map<String, dynamic> json) {
//     return LikePostResponse(
//       status: json['status'],
//       data: Post.fromJson(json['data']['post']),
//       code: json['code'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'data': data?.toJson(),
//       'code': code,
//     };
//   }
//
//   LikePostResponse.withError(String error){
//     status=AppConstants.status_error;
//     data=null;
//     code=0;
//   }
//
// }


class LikePostResponse {
  String? status;
  PostData? post;
  int? code;

  LikePostResponse({required this.status, required this.post, required this.code});

  factory LikePostResponse.fromJson(Map<String, dynamic> json) {
    return LikePostResponse(
      status: json['status'],
      post: PostData.fromJson(json['data']['post']),
      code: json['code'],
    );
  }

  LikePostResponse.withError(String error){
    status=AppConstants.status_error;
    post=null;
    code=0;
  }
}

