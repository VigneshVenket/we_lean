

import '../../models/day_ppc_week_activity.dart';

abstract class DayPpcState {}

class DayPpcInitial extends DayPpcState {}

class DayPpcLoading extends DayPpcState {}

class DayPpcLoaded extends DayPpcState {
  final List<DayPpcWeekActivity> weekActivities;

  DayPpcLoaded({required this.weekActivities});
}

class DayPpcError extends DayPpcState {
  final String errorMessage;

  DayPpcError({required this.errorMessage});
}
