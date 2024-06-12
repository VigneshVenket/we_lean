

import '../../models/variance_log_action.dart';

abstract class AddVarianceLogActionState {}

class AddVarianceLogActionInitial extends AddVarianceLogActionState {}

class AddVarianceLogActionLoading extends AddVarianceLogActionState {}

class AddVarianceLogActionSuccess extends AddVarianceLogActionState {
  final VarianceLogAction varianceLogAction;

  AddVarianceLogActionSuccess({required this.varianceLogAction});
}

class AddVarianceLogActionFailure extends AddVarianceLogActionState {
  final String errorMessage;

  AddVarianceLogActionFailure({required this.errorMessage});
}
