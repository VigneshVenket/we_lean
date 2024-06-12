


import '../../api/responses/posts_response.dart';

abstract class PostState{
  const PostState();

}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final PostResponse response;

  const PostSuccess(this.response);
}

class PostFailure extends PostState {
  final String error;

  const PostFailure(this.error);

}