

abstract class BarChartEvent {}

class FetchBarChartDataEvent extends BarChartEvent {
  final int userId;

  FetchBarChartDataEvent({required this.userId});
}


class FetchBarChartDataLocationwiseEvent extends BarChartEvent {
  final int userId;
  final int proj_loc_id;

  FetchBarChartDataLocationwiseEvent({required this.userId,required this.proj_loc_id});
}
