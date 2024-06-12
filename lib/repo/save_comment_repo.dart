



import 'package:we_lean/api/responses/save_comment_response.dart';

import '../api/apiData/api_provider.dart';

abstract class SaveCommentRepo {

  Future<SaveCommentResponse> addComment(int userId,int postId,String comment);
}

class RealSaveCommentRepo implements SaveCommentRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<SaveCommentResponse> addComment(int userId,int postId,String comment){
    return _apiProvider.addComment(userId, postId, comment);
  }
}