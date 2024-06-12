


import 'package:we_lean/api/responses/confirm_week_plan_response.dart';

import '../../models/confirm_week_plan.dart';

abstract class ConfirmWeekPlanState {}

class ConfirmWeekPlanLoadingState extends ConfirmWeekPlanState {}

class ConfirmWeekPlanLoadedState extends ConfirmWeekPlanState {
  final ConfirmWeekPlanResponse confirmWeekPlanResponse;


  ConfirmWeekPlanLoadedState(this.confirmWeekPlanResponse);

}

class ConfirmWeekPlanErrorState extends ConfirmWeekPlanState {
  final String errorMessage;

  ConfirmWeekPlanErrorState(this.errorMessage);

}