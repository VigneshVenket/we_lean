


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/delete_rootcause_repo.dart';

import 'delete_rootcause_event.dart';
import 'delete_rootcause_state.dart';

class RootCauseDeleteBloc extends Bloc<RootCauseDeleteEvent, RootCauseDeleteState> {

  final DeleteRootCauseRepo deleteRootCauseRepo;

  RootCauseDeleteBloc(this.deleteRootCauseRepo) : super(RootCauseDeleteInitial());

  @override
  Stream<RootCauseDeleteState> mapEventToState(RootCauseDeleteEvent event) async* {
    if (event is DeleteRootCauseEvent) {
      yield RootCauseDeleteLoading();
      try {
        final response = await deleteRootCauseRepo.deleteRootcause(event.varianceLogId, event.why);
        yield RootCauseDeleteSuccess(response);
      } catch (e) {
        yield RootCauseDeleteFailure('Failed to delete root cause: $e');
      }
    }
  }
}
