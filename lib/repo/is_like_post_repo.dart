



import '../api/apiData/api_provider.dart';
import '../api/responses/is_like_post_response.dart';

abstract class LikePostRepo {
  Future<LikePostResponse> addLikePosts(int postId);

}

class RealLikePostRepo implements LikePostRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<LikePostResponse> addLikePosts(int postId){
    return _apiProvider.addlikePost(postId);
  }

}