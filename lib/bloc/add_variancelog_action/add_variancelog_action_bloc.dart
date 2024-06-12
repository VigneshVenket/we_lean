
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/repo/add_action_repo.dart';

import '../../utils/app_constants.dart';
import 'add_variancelog_action_event.dart';
import 'add_variancelog_action_state.dart';

class AddVariancelogActionBloc extends Bloc<AddVarianceLogActionEvent, AddVarianceLogActionState> {
  final AddVarianceLogActionRepo addVarianceLogActionRepo;

  AddVariancelogActionBloc({required this.addVarianceLogActionRepo}) : super(AddVarianceLogActionInitial());

  @override
  Stream<AddVarianceLogActionState> mapEventToState(AddVarianceLogActionEvent event) async* {
    if (event is PerformAddVarianceLogAction) {
      yield AddVarianceLogActionLoading();
      try {
        final addvariancelogactionResponse = await addVarianceLogActionRepo.addActions(event.variancelogid, event.actiondata);
        if(addvariancelogactionResponse.status==AppConstants.status_success){
          yield AddVarianceLogActionSuccess(varianceLogAction:addvariancelogactionResponse.data!);
        }
         else{
          yield AddVarianceLogActionFailure(errorMessage:addvariancelogactionResponse.status!);
        }
      } catch (e) {
        yield AddVarianceLogActionFailure(errorMessage: e.toString());
      }
    }
  }
}