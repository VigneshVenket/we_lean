

import 'package:we_lean/repo/confirm_week_plan_repo.dart';

import 'confirm_week_plan_event.dart';
import 'confirm_week_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmWeekPlanBloc extends Bloc<ConfirmWeekPlanEvent, ConfirmWeekPlanState> {
  final ConfirmWeekPlanRepo _confirmWeekPlanRepo;

  ConfirmWeekPlanBloc(this._confirmWeekPlanRepo) : super(ConfirmWeekPlanLoadingState());

  @override
  Stream<ConfirmWeekPlanState> mapEventToState(ConfirmWeekPlanEvent event) async* {
    if (event is FetchConfirmWeekPlanEvent) {
      yield ConfirmWeekPlanLoadingState();
      try {
        // Replace this with your actual API call to fetch week plan
        final confirmWeekPlanResponse = await _confirmWeekPlanRepo.postConfirmWeekPlan(event.weekPlanId);
        yield ConfirmWeekPlanLoadedState(confirmWeekPlanResponse);

      } catch (e) {
        yield ConfirmWeekPlanErrorState(e.toString());
      }
    }
  }
}