

class OverallPPCData {
  final int weekPlanId;
  final int totalPlanned;
  final int totalActual;
  final String totalPPC;

  OverallPPCData({
    required this.weekPlanId,
    required this.totalPlanned,
    required this.totalActual,
    required this.totalPPC,
  });

  factory OverallPPCData.fromJson(Map<String, dynamic> json) {
    return OverallPPCData(
      weekPlanId: json['week_plan_id'],
      totalPlanned: json['total_planned'],
      totalActual: json['total_actual'],
      totalPPC: json['total_ppc'],
    );
  }
}
