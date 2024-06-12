


abstract class RootCauseDeleteEvent {}

class DeleteRootCauseEvent extends RootCauseDeleteEvent {
  final int varianceLogId;
  final String why;

  DeleteRootCauseEvent(this.varianceLogId,this.why);
}
