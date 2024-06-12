


import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:we_lean/repo/feed_post_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'feed_post_event.dart';
import 'feed_post_state.dart';


class FeedPostsBloc extends Bloc<FeedPostsEvent, FeedPostsState> {
  final FeedPostsRepo feedPostsRepo;

  FeedPostsBloc(this.feedPostsRepo) : super(FeedPostsInitial());

  @override
  Stream<FeedPostsState> mapEventToState(FeedPostsEvent event) async* {
    if (event is LoadFeedPosts) {
      yield FeedPostsLoading();
      try {
        final response = await feedPostsRepo.getFeedPosts();
        if(response.status==AppConstants.status_success){
          yield FeedPostsLoaded(posts:response.data!);
        }else{
          yield FeedPostsError(error: response.status!);
        }

      } catch (e) {
        yield FeedPostsError(error: e.toString());
      }
    }
  }
}
