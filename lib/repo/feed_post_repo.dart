


import 'package:we_lean/api/responses/draft_week_plan_response.dart';
import 'package:we_lean/api/responses/feed_posts_response.dart';

import '../api/apiData/api_provider.dart';

abstract class FeedPostsRepo {
  Future<FeedPostsResponse> getFeedPosts();

}

class RealFeedPostsRepo implements  FeedPostsRepo {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<FeedPostsResponse> getFeedPosts(){
    return _apiProvider.getFeedPosts();
  }

}