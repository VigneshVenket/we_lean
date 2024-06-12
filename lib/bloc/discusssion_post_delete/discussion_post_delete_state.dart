


abstract class DiscussionPostDeleteState {}

class DiscussionPostDeleteInitial extends DiscussionPostDeleteState {}

class DiscussionPostDeleteLoading extends DiscussionPostDeleteState {}

class DiscussionPostDeleteSuccess extends DiscussionPostDeleteState {
  final String status;

  DiscussionPostDeleteSuccess(this.status);
}

class DiscussionPostDeleteFailure extends DiscussionPostDeleteState {
  final String error;

  DiscussionPostDeleteFailure(this.error);
}