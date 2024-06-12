

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/delete_weekActivity/delete_weekactivity_event.dart';
import 'package:we_lean/bloc/delete_weekActivity/delete_weekactivity_state.dart';
import 'package:we_lean/repo/delete_weekactivity_repo.dart';

import '../../utils/app_constants.dart';


class DeleteWeekActivityBloc extends Bloc<DeleteWeekActivityEvent, DeleteWeekActivityState> {
  final DeleteWeekActivityRepo deleteWeekActivityRepo;

  DeleteWeekActivityBloc(this.deleteWeekActivityRepo) : super(DeleteWeekActivityInitial());

  @override
  Stream<DeleteWeekActivityState> mapEventToState(DeleteWeekActivityEvent event) async* {
    if (event is DeleteWeekActivity) {
      yield DeleteWeekActivityLoading();
      try {
        final response = await deleteWeekActivityRepo.deleteWeekActivity(event.weekActivityId);
        if(response.status==AppConstants.status_success){
          yield DeleteWeekActivityDeleted(deleteWeekActivityResponse: response);
        }else{
          yield DeleteWeekActivityError(response.message!);
        }
      } catch (error) {
        yield DeleteWeekActivityError(error.toString());
      }
    }
  }
}