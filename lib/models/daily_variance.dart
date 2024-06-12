

class DailyVariance {
  final String date;
  final int day;
  final int planned;
  final int actual;
  final String ppc;
  final List<int> varianceLogIds;

  DailyVariance({
    required this.date,
    required this.day,
    required this.planned,
    required this.actual,
    required this.ppc,
    required this.varianceLogIds,
  });

  factory DailyVariance.fromJson(Map<String, dynamic> json) {
    return DailyVariance(
      date: json['date'],
      day: json['day'],
      planned: json['planned'],
      actual: json['actual'],
      ppc: json['ppc'],
      varianceLogIds: List<int>.from(json['variance_log_ids']),
    );
  }
}
