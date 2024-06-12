
import '../../models/user_location_plan.dart';

abstract class UserLocationPlanState {}

class UserLocationPlanInitialState extends UserLocationPlanState {}

class UserLocationPlanLoadingState extends UserLocationPlanState {}

class UserLocationPlanLoadedState extends UserLocationPlanState {
  final List<UserLocationPlan> userLocationPlans;

  UserLocationPlanLoadedState(this.userLocationPlans);
}

class UserLocationPlanErrorState extends UserLocationPlanState {
  final String error;

  UserLocationPlanErrorState(this.error);
}