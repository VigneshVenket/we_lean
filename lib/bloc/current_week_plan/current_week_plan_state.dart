


import 'package:we_lean/api/responses/current_week_plan_activity_response.dart';

import '../../models/current_week_plan_activity.dart';

abstract class CurrentWeekPlanState {}

class CurrentWeekPlanStateInitial extends CurrentWeekPlanState {
  // Properties...
}

// BLoC state class for indicating that the current week plan is being loaded
class CurrentWeekPlanStateLoading extends CurrentWeekPlanState {
  // Properties...
}

// BLoC state class for indicating that the current week plan has been successfully loaded
class CurrentWeekPlanStateLoaded extends CurrentWeekPlanState{
  final CurrentWeekPlanResponse currentWeekPlanResponse;

  CurrentWeekPlanStateLoaded({required this.currentWeekPlanResponse});
}

// BLoC state class for indicating an error while loading the current week plan
class CurrentWeekPlanStateError extends CurrentWeekPlanState{
  final String errorMessage;

  CurrentWeekPlanStateError({required this.errorMessage});
}