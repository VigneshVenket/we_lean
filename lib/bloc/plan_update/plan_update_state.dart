


import 'package:we_lean/api/responses/plan_update_response.dart';

import '../../models/plan_upadate.dart';

abstract class PlanUpdateState {}

class PlanUpdateInitial extends PlanUpdateState {}

class PlanUpdateLoading extends PlanUpdateState {}

class PlanUpdateLoaded extends PlanUpdateState {
  final PlanUpdateResponse planUpdate;

  PlanUpdateLoaded({required this.planUpdate});
}

class PlanUpdateError extends PlanUpdateState {
  final String errorMessage;

  PlanUpdateError({required this.errorMessage});
}
