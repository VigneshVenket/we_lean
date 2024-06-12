


import 'package:we_lean/repo/current_week_plan_activity_repo.dart';

import '../../utils/app_constants.dart';
import 'current_week_plan_event.dart';
import 'current_week_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentWeekPlanBloc extends Bloc<CurrentWeekPlanEvent, CurrentWeekPlanState> {
  final CurrentWeekPlanRepo currentWeekPlanRepo;

  CurrentWeekPlanBloc(this.currentWeekPlanRepo) : super(CurrentWeekPlanStateInitial());

  @override
  Stream<CurrentWeekPlanState> mapEventToState(CurrentWeekPlanEvent event) async* {
    if (event is FetchCurrentWeekPlanEvent) {
      yield CurrentWeekPlanStateLoading();
      try {
        final currentWeekPlanResponse = await currentWeekPlanRepo.getCurrentWekPlan(event.userId);
        if(currentWeekPlanResponse.status==AppConstants.status_success){
          yield CurrentWeekPlanStateLoaded(currentWeekPlanResponse: currentWeekPlanResponse);
        }else{
          yield CurrentWeekPlanStateError(errorMessage: currentWeekPlanResponse.status!);
        }
      } catch (e) {
        yield CurrentWeekPlanStateError(errorMessage: e.toString());
      }
    }
    else if (event is FetchCurrentWeekPlanLocationwiseEvent) {
      yield CurrentWeekPlanStateLoading();
      try {
        final currentWeekPlanResponse = await currentWeekPlanRepo.getCurrentWekPlanLocationwise(event.userId,event.proj_loc_id);
        if(currentWeekPlanResponse.status==AppConstants.status_success){
          yield CurrentWeekPlanStateLoaded(currentWeekPlanResponse: currentWeekPlanResponse);
        }else{
          yield CurrentWeekPlanStateError(errorMessage: currentWeekPlanResponse.status!);
        }
      } catch (e) {
        yield CurrentWeekPlanStateError(errorMessage: e.toString());
      }
    }
    else if (event is FetchPreviousWeekPlanEvent) {
      yield CurrentWeekPlanStateLoading();
      try {
        final currentWeekPlanResponse = await currentWeekPlanRepo.getPreviousWekPlan(event.userId);
        if(currentWeekPlanResponse.status==AppConstants.status_success){
          yield CurrentWeekPlanStateLoaded(currentWeekPlanResponse: currentWeekPlanResponse);
        }else{
          yield CurrentWeekPlanStateError(errorMessage: currentWeekPlanResponse.status!);
        }
      } catch (e) {
        yield CurrentWeekPlanStateError(errorMessage: e.toString());
      }
    }
  }
}