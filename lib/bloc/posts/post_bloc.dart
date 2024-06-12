


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/posts_repo.dart';
import 'package:we_lean/utils/app_constants.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepo postsRepo;

  PostBloc(this.postsRepo) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is SavePost) {
      yield PostLoading();
      try {
        // Here you would make your API call and parse the response
        final response = await postsRepo.addPost(event.userId, event.description, event.postImgUrl);
       if(response.status==AppConstants.status_success){
         yield PostSuccess(response);
       }else{
         yield PostFailure(response.message!);
       }

      } catch (e) {
        yield PostFailure(e.toString());
      }
    }
  }

}
