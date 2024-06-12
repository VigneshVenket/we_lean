


abstract class LikePostEvent {}

class LikePost extends LikePostEvent {
  final int postId;

  LikePost({required this.postId});
}