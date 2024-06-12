

import '../../api/responses/bar_chart_ppc_response.dart';

abstract class BarChartState {}

class BarChartInitialState extends BarChartState {}

class BarChartLoadingState extends BarChartState {}

class BarChartLoadedState extends BarChartState {
  final BarChartResponse barChartResponse;

  BarChartLoadedState({required this.barChartResponse});
}

class BarChartErrorState extends BarChartState {
  final String error;

  BarChartErrorState({required this.error});
}
