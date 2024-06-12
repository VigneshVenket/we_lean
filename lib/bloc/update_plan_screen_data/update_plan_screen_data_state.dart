

// State class for update plan screen
import '../../api/responses/update_plan_screen_data_response.dart';

abstract class UpdatePlanScreenState {}

class UpdatePlanScreenStateInitial extends UpdatePlanScreenState {}

class UpdatePlanScreenStateLoading extends UpdatePlanScreenState {}

class UpdatePlanScreenStateLoaded extends UpdatePlanScreenState {
  final UpdatePlanScreenResponse response;

  UpdatePlanScreenStateLoaded({required this.response});
}

class UpdatePlanScreenStateError extends UpdatePlanScreenState {
  final String message;

  UpdatePlanScreenStateError({required this.message});
}