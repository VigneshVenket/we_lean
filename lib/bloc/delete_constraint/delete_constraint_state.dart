



import 'package:we_lean/api/responses/delete_constraint_response.dart';

abstract class ConstraintLogState {
  const ConstraintLogState();


}

class ConstraintLogInitial extends ConstraintLogState {}

class ConstraintLogLoading extends ConstraintLogState {}

class ConstraintLogDeleted extends ConstraintLogState {
  final DeleteConstraintLogResponse deleteConstraintLogResponse;

  const ConstraintLogDeleted(this.deleteConstraintLogResponse);

}

class ConstraintLogError extends ConstraintLogState {
  final String error;

  const ConstraintLogError(this.error);

}
