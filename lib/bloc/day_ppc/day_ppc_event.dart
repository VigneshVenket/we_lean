

abstract class DayPpcEvent {}

class FetchDayPpcWeekActivities extends DayPpcEvent {
  final int weekActivityId;

  FetchDayPpcWeekActivities({required this.weekActivityId});

}
