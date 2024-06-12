

abstract class DeleteWeekActivityEvent {}

class DeleteWeekActivity extends DeleteWeekActivityEvent {
  final int weekActivityId;

  DeleteWeekActivity(this.weekActivityId);
}
