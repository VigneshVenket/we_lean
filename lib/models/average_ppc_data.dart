


class AveragePPCDataDetail {
  final List<int> weekPlanIds;
  final int totalPlanned;
  final int totalActual;
  final String totalPPC;

  AveragePPCDataDetail({
    required this.weekPlanIds,
    required this.totalPlanned,
    required this.totalActual,
    required this.totalPPC,
  });

  factory AveragePPCDataDetail.fromJson(Map<String, dynamic> json) {
    return AveragePPCDataDetail(
      weekPlanIds: List<int>.from(json['week_plan_ids']),
      totalPlanned: json['total_planned'],
      totalActual: json['total_actual'],
      totalPPC: json['total_ppc'],
    );
  }
}