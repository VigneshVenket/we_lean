


abstract class DraftWeekPlanEvent {}

class FetchDraftWeekPlan extends DraftWeekPlanEvent {
  final int userId;
  final int proj_loc_id;

  FetchDraftWeekPlan({required this.userId,required this.proj_loc_id});
}