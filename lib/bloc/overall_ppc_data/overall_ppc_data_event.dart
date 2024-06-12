

abstract class OverallPPCEvent {}

class FetchOverallPPCDataEvent extends OverallPPCEvent {
  final int userId;

  FetchOverallPPCDataEvent({required this.userId});
}

class FetchOverallPPCDataLocationwiseEvent extends OverallPPCEvent {
  final int userId;
  final int projLocId;

  FetchOverallPPCDataLocationwiseEvent({required this.userId,required this.projLocId});
}
