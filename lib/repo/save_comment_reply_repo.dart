


import '../api/apiData/api_provider.dart';
import '../api/responses/save_comment_reply.dart';

abstract class SaveCommentReplyRepo {

  Future<SaveCommentReplyResponse> addCommentReply(int userId,int commentId,String comment);
}

class RealSaveCommentReplyRepo implements SaveCommentReplyRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<SaveCommentReplyResponse> addCommentReply(int userId,int commentId,String comment){
    return _apiProvider.addCommentReply(userId, commentId, comment);
  }
}