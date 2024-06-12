
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_event.dart';
import 'package:we_lean/bloc/discusssion_post_delete/discussion_post_delete_state.dart';
import 'package:we_lean/repo/discussion_post_delete_repo.dart';


class DiscussionPostDeleteBloc extends Bloc<DiscussionPostDeleteEvent,DiscussionPostDeleteState> {

  final DiscussionPostDeleteRepo discussionPostDeleteRepo;

  DiscussionPostDeleteBloc(this.discussionPostDeleteRepo) : super(DiscussionPostDeleteInitial());

  @override
  Stream<DiscussionPostDeleteState> mapEventToState(DiscussionPostDeleteEvent event) async* {
    if (event is DeletePostEvent) {
      yield DiscussionPostDeleteLoading();
      try {
        final response = await discussionPostDeleteRepo.deletePost(event.postId, event.userId);
        yield DiscussionPostDeleteSuccess(response.status!);
      } catch (e) {
        yield DiscussionPostDeleteFailure('Failed to delete root cause: $e');
      }
    }
    else if (event is DeleteCommentEvent) {
      yield DiscussionPostDeleteLoading();
      try {
        final response = await discussionPostDeleteRepo.deleteComment(event.commentId, event.userId);
        yield DiscussionPostDeleteSuccess(response.status!);
      } catch (e) {
        yield DiscussionPostDeleteFailure('Failed to delete root cause: $e');
      }
    }
    else if (event is DeleteCommentReplyEvent) {
      yield DiscussionPostDeleteLoading();
      try {
        final response = await discussionPostDeleteRepo.deleteReplyComment(event.commentReplyId, event.userId);
        yield DiscussionPostDeleteSuccess(response.status!);
      } catch (e) {
        yield DiscussionPostDeleteFailure('Failed to delete root cause: $e');
      }
    }
  }
}