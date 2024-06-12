



import '../../models/draft_week_plan.dart';

abstract class DraftWeekPlanState {}

class DraftWeekPlanInitial extends DraftWeekPlanState {}

class DraftWeekPlanLoading extends DraftWeekPlanState {}

class DraftWeekPlanLoaded extends DraftWeekPlanState {
  final List<DraftWeekPlan> draftWeekPlans;

  DraftWeekPlanLoaded({required this.draftWeekPlans});

  get userLocationPlans => null;
}

class DraftWeekPlanError extends DraftWeekPlanState {
  final String message;

  DraftWeekPlanError({required this.message});
}

