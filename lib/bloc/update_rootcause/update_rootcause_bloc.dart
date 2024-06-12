



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/update_rootcause/update_rootcause_state.dart';
import 'package:we_lean/bloc/update_rootcause/update_rrotcause_event.dart';
import 'package:we_lean/repo/update_root_cause_repo.dart';

class RootCauseUpdateBloc extends Bloc<RootCauseUpdateEvent, RootCauseUpdateState> {

  final UpdateRootCauseRepo updateRootCauseRepo;

  RootCauseUpdateBloc(this.updateRootCauseRepo) : super(RootCauseUpdateInitial());

  @override
  Stream<RootCauseUpdateState> mapEventToState(RootCauseUpdateEvent event) async* {
    if (event is RootCauseUpdated) {
      yield RootCauseUpdateInitial();
      try {
        final rootCauseUpdateResponse = await updateRootCauseRepo.updateRootCause(
            event.varianceId, event.why1, event.why2,event.why3, event.why4, event.why5,
            event.groupId1,event.groupId2,event.groupId3,event.groupId4,event.groupId5
        );
          yield RootCauseUpdateSuccess(rootCauseUpdateResponse: rootCauseUpdateResponse);
      } catch (e) {
        yield RootCauseUpdateFailure(error: e.toString());
      }
    }
  }
}