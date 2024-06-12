

import '../../api/responses/week_variance_graph_response.dart';

abstract class WeekVariancePPCState {}

class WeekVariancePPCInitial extends WeekVariancePPCState {}

class WeekVariancePPCLoading extends WeekVariancePPCState {}

class WeekVariancePPCDataLoaded extends WeekVariancePPCState {
  final WeekVariancePPCResponse weekVariancePPCResponse;

  WeekVariancePPCDataLoaded({required this.weekVariancePPCResponse});
}

class WeekVariancePPCError extends WeekVariancePPCState {
  final String message;

  WeekVariancePPCError({required this.message});
}