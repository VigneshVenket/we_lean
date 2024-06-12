


import 'package:we_lean/api/responses/discussion_post_delete_response.dart';

import '../api/apiData/api_provider.dart';

abstract class DiscussionPostDeleteRepo {
  Future<DiscussionPostDeleteResponse> deletePost(int postId,int userId);
  Future<DiscussionPostDeleteResponse> deleteComment(int commentId,int userId);
  Future<DiscussionPostDeleteResponse> deleteReplyComment(int replyCommentId,int userId);

}

class RealDiscussionPostDeleteRepo  implements  DiscussionPostDeleteRepo  {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DiscussionPostDeleteResponse> deletePost(int postId,int userId){
    return _apiProvider.deletePost(postId, userId);
  }

  Future<DiscussionPostDeleteResponse> deleteComment(int commentId,int userId){
    return _apiProvider.deleteComment(commentId, userId);
  }

  Future<DiscussionPostDeleteResponse> deleteReplyComment(int replyCommentId,int userId){
    return _apiProvider.deleteCommentReply(replyCommentId, userId);
  }

}