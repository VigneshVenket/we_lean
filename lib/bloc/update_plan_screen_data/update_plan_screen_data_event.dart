

abstract class UpdatePlanScreenEvent {}

class FetchUpdatePlanScreenData extends UpdatePlanScreenEvent {
  final int weekActivityId;

  FetchUpdatePlanScreenData({required this.weekActivityId});
}