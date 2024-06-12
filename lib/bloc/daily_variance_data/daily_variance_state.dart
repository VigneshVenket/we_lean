

import '../../models/daily_variance.dart';

class DailyVarianceState {
  const DailyVarianceState();
}

class DailyVarianceInitial extends DailyVarianceState {}

class DailyVarianceLoading extends DailyVarianceState {}

class DailyVarianceLoaded extends DailyVarianceState {
  final List<DailyVariance> varianceData;

  const DailyVarianceLoaded({required this.varianceData});
}

class DailyVarianceError extends DailyVarianceState {
  final String errorMessage;

  const DailyVarianceError({required this.errorMessage});
}
