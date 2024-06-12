


abstract class UserLocationPlanEvent {}

class FetchUserLocationPlanEvent extends UserLocationPlanEvent {
  final int userId;

  FetchUserLocationPlanEvent(this.userId);
}

class FetchUserLocationPlanLocationwiseEvent extends UserLocationPlanEvent {
  final int userId;
  final int proj_loc_id;

  FetchUserLocationPlanLocationwiseEvent(this.userId,this.proj_loc_id);
}