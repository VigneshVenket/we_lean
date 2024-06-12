


import 'package:equatable/equatable.dart';
import '../../models/feed_posts.dart';


abstract class FeedPostsState {
  const FeedPostsState();

}

class FeedPostsInitial extends FeedPostsState {}

class FeedPostsLoading extends FeedPostsState {}

class FeedPostsLoaded extends FeedPostsState {
  final List<Post> posts;

  FeedPostsLoaded({required this.posts});

}

class FeedPostsError extends FeedPostsState {
  final String error;

  FeedPostsError({required this.error});

}
