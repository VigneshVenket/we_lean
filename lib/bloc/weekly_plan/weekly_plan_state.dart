

import '../../api/responses/weekly_plan_response.dart';

abstract class WeeklyPlanState {
  const WeeklyPlanState();
}

class WeeklyPlanInitial extends WeeklyPlanState {
  const WeeklyPlanInitial();
}

class WeeklyPlanLoading extends WeeklyPlanState {
  const WeeklyPlanLoading();
}

class WeeklyPlanLoaded extends WeeklyPlanState {
  final WeeklyPlanResponse weeklyPlanResponse;

  const WeeklyPlanLoaded({required this.weeklyPlanResponse});
}

class WeeklyPlanError extends WeeklyPlanState {
  final String errorMessage;

  const WeeklyPlanError({required this.errorMessage});

}
