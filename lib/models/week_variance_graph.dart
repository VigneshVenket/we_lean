


class WeekVariancePPCDay {
  final int count;
  final List<int> varianceLogIds;

  WeekVariancePPCDay({
    required this.count,
    required this.varianceLogIds,
  });

  factory WeekVariancePPCDay.fromJson(Map<String, dynamic> json) {
    final List<dynamic> idsJson = json['variance_log_ids'];
    final List<int> ids = idsJson.cast<int>();

    return WeekVariancePPCDay(
      count: json['count'],
      varianceLogIds: ids,
    );
  }
}