

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/save_comment/save_comment_event.dart';
import 'package:we_lean/bloc/save_comment/save_comment_state.dart';
import 'package:we_lean/repo/save_comment_repo.dart';
import 'package:we_lean/utils/app_constants.dart';


class SaveCommentBloc extends Bloc<SaveCommentEvent, SaveCommentState> {
  final SaveCommentRepo saveCommentRepo;

  SaveCommentBloc(this.saveCommentRepo) : super(SaveCommentInitial());

  @override
  Stream<SaveCommentState> mapEventToState(SaveCommentEvent event) async* {
    if (event is SubmitComment) {
      yield SaveCommentLoading();
      try {
        final response = await saveCommentRepo.addComment(event.userId, event.postId,event.comments);
        if(response.status==AppConstants.status_success){
          yield SaveCommentSuccess(comment:response.data!);
        }else{
          yield SaveCommentFailure(error:response.status!);
        }

      } catch (e) {
        yield SaveCommentFailure(error: e.toString());
      }
    }
  }
}
