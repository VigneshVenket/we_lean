

abstract class WeeklyPlanEvent {}

class FetchWeeklyPlan extends WeeklyPlanEvent {
  final int weekActivityId;

  FetchWeeklyPlan(this.weekActivityId);
}