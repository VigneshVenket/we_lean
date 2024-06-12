

abstract class ApprovalEvent {}

class SubmitApprovalEvent extends ApprovalEvent {
  final int weekPlanId;
  final int userId;
  final String status;

  SubmitApprovalEvent({
    required this.weekPlanId,
    required this.userId,
    required this.status,
  });
}