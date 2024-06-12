

abstract class DailyVarianceEvent {
  const DailyVarianceEvent();
}

class FetchDailyVarianceData extends DailyVarianceEvent {
  final int week_plan_id;

  FetchDailyVarianceData({required this.week_plan_id});

}