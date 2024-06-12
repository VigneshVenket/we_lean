


import 'dart:io';

import 'package:we_lean/api/responses/posts_response.dart';

import '../api/apiData/api_provider.dart';

abstract class PostsRepo {

  Future<PostResponse> addPost(int userId,String description,File postImgUrl);
}

class RealPostsRepo implements PostsRepo {

  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<PostResponse> addPost(int userId,String description,File postImgUrl){
    return _apiProvider.addPost(userId, description, postImgUrl);
  }
}