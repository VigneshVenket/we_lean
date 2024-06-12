

abstract class CurrentWeekPlanEvent {}

class FetchCurrentWeekPlanEvent extends CurrentWeekPlanEvent {
  final int userId;

  FetchCurrentWeekPlanEvent({required this.userId});
}

class FetchCurrentWeekPlanLocationwiseEvent extends CurrentWeekPlanEvent {
  final int userId;
  final int proj_loc_id;

  FetchCurrentWeekPlanLocationwiseEvent({required this.userId,required this.proj_loc_id});
}

class FetchPreviousWeekPlanEvent extends CurrentWeekPlanEvent {
  final int userId;

  FetchPreviousWeekPlanEvent({required this.userId});
}