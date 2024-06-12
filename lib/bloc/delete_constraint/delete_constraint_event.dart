




abstract class ConstraintLogEvent  {
  const ConstraintLogEvent();

}

class DeleteConstraintLog extends ConstraintLogEvent {
  final int constraintId;

  const DeleteConstraintLog(this.constraintId);

}
