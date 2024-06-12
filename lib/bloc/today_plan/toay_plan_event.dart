


abstract class TodayPlanEvent {}

class FetchTodayPlan extends TodayPlanEvent {
  final int userId;

  FetchTodayPlan({required this.userId});
}


class FetchTodayPlanLocationwise extends TodayPlanEvent {
  final int userId;
  final int proj_loc_id;

  FetchTodayPlanLocationwise({required this.userId,required this.proj_loc_id});
}
