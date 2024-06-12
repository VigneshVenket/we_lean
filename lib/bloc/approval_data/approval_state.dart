

import '../../models/approval_data.dart';

abstract class ApprovalState {}

class ApprovalInitial extends ApprovalState {}

class ApprovalLoaded extends ApprovalState {
  final ApprovalData approvalResponse;

  ApprovalLoaded({required this.approvalResponse});
}

class ApprovalError extends ApprovalState {
  final String errorMessage;

  ApprovalError({required this.errorMessage});
}