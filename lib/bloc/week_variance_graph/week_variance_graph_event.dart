


abstract class WeekVariancePPCEvent {}

class FetchWeekVariancePPCData extends WeekVariancePPCEvent {
  final int userId;

  FetchWeekVariancePPCData({required this.userId});
}


class FetchWeekVariancePPCDataLocationwise extends WeekVariancePPCEvent {
  final int userId;
  final int proj_loc_id;

  FetchWeekVariancePPCDataLocationwise({required this.userId,required this.proj_loc_id});
}