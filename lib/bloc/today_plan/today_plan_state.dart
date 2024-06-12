


import 'package:meta/meta.dart';

import '../../api/responses/today_plan_response.dart';

abstract class TodayPlanState {}

class TodayPlanInitial extends TodayPlanState {}

class TodayPlanLoading extends TodayPlanState {}

class TodayPlanLoaded extends TodayPlanState {
  final TodayPlanResponse todayPlanResponse;

  TodayPlanLoaded({required this.todayPlanResponse});
}

class TodayPlanError extends TodayPlanState {
  final String error;

  TodayPlanError({required this.error});
}
