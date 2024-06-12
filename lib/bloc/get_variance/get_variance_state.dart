


import '../../api/responses/get_variances_response.dart';

abstract class VariancesState{
  const VariancesState();

  @override
  List<Object?> get props => [];
}

class VariancesInitial extends VariancesState {}

class VariancesLoading extends VariancesState {}

class VariancesLoaded extends VariancesState {
  final VariancesResponse variancesResponse;

  const VariancesLoaded(this.variancesResponse);

  @override
  List<Object?> get props => [variancesResponse];
}

class VariancesError extends VariancesState {
  final String message;

  const VariancesError(this.message);

  @override
  List<Object?> get props => [message];
}
