


import '../../api/responses/delete_rootcause_response.dart';

abstract class RootCauseDeleteState {}

class RootCauseDeleteInitial extends RootCauseDeleteState {}

class RootCauseDeleteLoading extends RootCauseDeleteState {}

class RootCauseDeleteSuccess extends RootCauseDeleteState {
  final RootCauseDeleteResponse response;

  RootCauseDeleteSuccess(this.response);
}

class RootCauseDeleteFailure extends RootCauseDeleteState {
  final String error;

  RootCauseDeleteFailure(this.error);
}
