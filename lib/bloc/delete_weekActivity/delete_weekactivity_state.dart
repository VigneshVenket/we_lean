


import 'package:we_lean/api/responses/delete_weekactivity_response.dart';

abstract class DeleteWeekActivityState {}

class DeleteWeekActivityInitial extends DeleteWeekActivityState {}

class DeleteWeekActivityLoading extends DeleteWeekActivityState {}

class DeleteWeekActivityDeleted extends DeleteWeekActivityState {

  final DeleteWeekActivityResponse deleteWeekActivityResponse;

  DeleteWeekActivityDeleted({required this.deleteWeekActivityResponse});

}

class DeleteWeekActivityError extends DeleteWeekActivityState{
  final String message;

  DeleteWeekActivityError(this.message);
}
