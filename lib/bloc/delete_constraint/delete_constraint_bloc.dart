



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/delete_constraint_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

import 'delete_constraint_event.dart';
import 'delete_constraint_state.dart';


class ConstraintLogBloc extends Bloc<ConstraintLogEvent, ConstraintLogState> {
 final DeleteConstraintRepo deleteConstraintRepo;

  ConstraintLogBloc(this.deleteConstraintRepo) : super(ConstraintLogInitial());

  @override
  Stream<ConstraintLogState> mapEventToState(ConstraintLogEvent event) async* {
    if (event is DeleteConstraintLog) {
      yield ConstraintLogLoading();
      try {
        final response = await deleteConstraintRepo.deleteConstraint(event.constraintId);
         if(response.status==AppConstants.status_success){
           yield ConstraintLogDeleted(response);
         }else{
           yield ConstraintLogError(response.message!);
         }
      } catch (error) {
        yield ConstraintLogError(error.toString());
      }
    }
  }
}
