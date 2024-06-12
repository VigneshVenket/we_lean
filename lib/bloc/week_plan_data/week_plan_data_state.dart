

import '../../models/week_plan_data.dart';

abstract class WeekPlanDataState {}

class WeekPlanDataInitial extends WeekPlanDataState {}

class WeekPlanDataLoaded extends WeekPlanDataState {
  final WeekPlanData weekPlanData;

  WeekPlanDataLoaded(this.weekPlanData);
}

class WeekPlanDataError extends WeekPlanDataState{
  final String errorMessage;

  WeekPlanDataError(this.errorMessage);
}