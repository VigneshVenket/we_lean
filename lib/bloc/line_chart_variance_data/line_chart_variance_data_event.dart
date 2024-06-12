


abstract class LineChartVarianceEvent {}

class FetchLineChartVarianceData extends LineChartVarianceEvent {

  final String varianceId;

  FetchLineChartVarianceData({required this.varianceId});

}