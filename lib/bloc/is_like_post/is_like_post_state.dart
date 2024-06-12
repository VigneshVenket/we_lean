
import '../../api/responses/is_like_post_response.dart';

abstract class LikePostState {}

class LikePostInitial extends LikePostState {}

class LikePostLoading extends LikePostState {}

class LikePostSuccess extends LikePostState {
  final LikePostResponse response;

  LikePostSuccess({required this.response});
}

class LikePostFailure extends LikePostState {
  final String error;

  LikePostFailure({required this.error});
}
