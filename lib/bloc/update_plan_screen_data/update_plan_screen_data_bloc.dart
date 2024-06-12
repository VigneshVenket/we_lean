
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/update_plan_screen_data/update_plan_screen_data_event.dart';
import 'package:we_lean/bloc/update_plan_screen_data/update_plan_screen_data_state.dart';
import 'package:we_lean/repo/update_plan_screen_data_repo.dart';
import 'package:we_lean/utils/app_constants.dart';

class UpdatePlanScreenBloc extends Bloc<UpdatePlanScreenEvent, UpdatePlanScreenState> {
  final UpdatePlanScreenRepo updatePlanScreenRepo;

  UpdatePlanScreenBloc({required this.updatePlanScreenRepo}) : super(UpdatePlanScreenStateInitial());

  @override
  Stream<UpdatePlanScreenState> mapEventToState(UpdatePlanScreenEvent event) async* {
    if (event is FetchUpdatePlanScreenData){
      yield UpdatePlanScreenStateLoading();
      try {
        final updatePlanScreenResponse = await updatePlanScreenRepo.getCurrentWeekDayPlan(event.weekActivityId);
        if (updatePlanScreenResponse.status == AppConstants.status_success) {
          yield UpdatePlanScreenStateLoaded(response:updatePlanScreenResponse );
        } else {
          yield UpdatePlanScreenStateError(message: updatePlanScreenResponse.status!);
        }
      } catch (e) {
        yield UpdatePlanScreenStateError(message: e.toString());
      }
    }

  }
}