

import 'package:we_lean/api/responses/line_chart_variance_data_response.dart';

import '../../models/line_chart_variance_data.dart';

abstract class LineChartVarianceState {}

class LineChartVarianceInitialState extends LineChartVarianceState {}

class LineChartVarianceLoadingState extends LineChartVarianceState {}

class LineChartVarianceLoadedState extends LineChartVarianceState {
  final LineChartVarianceResponse lineChartVarianceresponse;

  LineChartVarianceLoadedState(this.lineChartVarianceresponse);
}

class LineChartVarianceErrorState extends LineChartVarianceState {
  final String errorMessage;

  LineChartVarianceErrorState(this.errorMessage);
}