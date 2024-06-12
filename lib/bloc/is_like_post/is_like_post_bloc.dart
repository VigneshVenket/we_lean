
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/is_like_post_repo.dart';

import 'is_like_post_event.dart';
import 'is_like_post_state.dart';



class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final  LikePostRepo likePostRepo;

  LikePostBloc({required this.likePostRepo}) : super(LikePostInitial());

  @override
  Stream<LikePostState> mapEventToState(LikePostEvent event) async* {


    print('Current state: ${state.runtimeType}');
    if (event is LikePost) {
      yield LikePostLoading();
      try {
        print("bloc");
        final response = await likePostRepo.addLikePosts(event.postId);
        print(response.status);
        yield LikePostSuccess(response: response);

      } catch (e) {
        yield LikePostFailure(error: e.toString());

        // print(e.toString());
        print(e);
      }
    }
  }
}