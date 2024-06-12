

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/save_comment_reply/save_comment_reply_event.dart';
import 'package:we_lean/bloc/save_comment_reply/save_comment_reply_state.dart';
import 'package:we_lean/repo/save_comment_reply_repo.dart';

class SaveCommentReplyBloc extends Bloc<SaveCommentReplyEvent, SaveCommentReplyState> {
  final SaveCommentReplyRepo saveCommentReplyRepo;

  SaveCommentReplyBloc(this.saveCommentReplyRepo) : super(SaveCommentReplyInitial());

  @override
  Stream<SaveCommentReplyState> mapEventToState(SaveCommentReplyEvent event) async* {
    if (event is SubmitCommentReply) {
      yield SaveCommentReplyLoading();
      try {
          final response = await saveCommentReplyRepo.addCommentReply(event.userId, event.commentId,event.comments);
          if (response.status == "Success") {
            yield SaveCommentReplySuccess(response.data!);
          } else {
            yield SaveCommentReplyFailure(response.message!);
          }
      } catch (error) {
        yield SaveCommentReplyFailure(error.toString());
      }
    }
  }
}
