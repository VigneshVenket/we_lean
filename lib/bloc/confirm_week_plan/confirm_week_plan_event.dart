


abstract class ConfirmWeekPlanEvent {}

class FetchConfirmWeekPlanEvent extends ConfirmWeekPlanEvent {

  final int weekPlanId;

  FetchConfirmWeekPlanEvent({required this.weekPlanId});
}