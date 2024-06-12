
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_lean/bloc/weekly_plan/weekly_plan_event.dart';
import 'package:we_lean/bloc/weekly_plan/weekly_plan_state.dart';
import 'package:we_lean/utils/app_constants.dart';

import '../../repo/weekly_plan_repo.dart';


class WeeklyPlanBloc extends Bloc<WeeklyPlanEvent, WeeklyPlanState> {
  final WeeklyPlanRepo weeklyPlanRepo;

  WeeklyPlanBloc(this.weeklyPlanRepo) : super(WeeklyPlanInitial());

  @override
  Stream<WeeklyPlanState> mapEventToState(WeeklyPlanEvent event) async* {
    if (event is FetchWeeklyPlan) {
      yield WeeklyPlanLoading();
      try {
        final weeklyPlanResponse = await weeklyPlanRepo.getWeeklyPlan(event.weekActivityId);
        if(weeklyPlanResponse.status==AppConstants.status_success){
          yield WeeklyPlanLoaded(weeklyPlanResponse: weeklyPlanResponse);
        }else{
          yield WeeklyPlanError(errorMessage: weeklyPlanResponse.status!);
        }
      } catch (e) {
        yield WeeklyPlanError(errorMessage: e.toString());
      }
    }
  }
}
