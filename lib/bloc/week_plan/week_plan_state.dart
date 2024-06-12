

import 'package:we_lean/api/responses/week_plan_response.dart';

abstract class WeekPlanCreateState {}

class WeekPlanCreateInitialState extends WeekPlanCreateState {}

class WeekPlanCreateLoadingState extends WeekPlanCreateState {}

class WeekPlanCreateSuccessState extends WeekPlanCreateState {
  final WeekPlanResponse weekPlanResponse;

  WeekPlanCreateSuccessState({required this.weekPlanResponse});
}

class WeekPlanCreateErrorState extends WeekPlanCreateState {
  final String error;

  WeekPlanCreateErrorState({required this.error});
}