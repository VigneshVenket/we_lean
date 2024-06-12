
class PlanUpdate {
  final int id;
  final int weekPlanId;
  final int categoryId;
  final int weekDay;
  final String weekDate;
  final int activityId;
  final int uomId;
  final String activityOther;
  final int plannedQty;
  final int actualQty;
  final int isActive;
  final int status;
  final String createdAt;
  final String updatedAt;
  // final List<PlanVarianceLog> varianceLogs;

  PlanUpdate({
    required this.id,
    required this.weekPlanId,
    required this.categoryId,
    required this.weekDay,
    required this.weekDate,
    required this.activityId,
    required this.uomId,
    required this.activityOther,
    required this.plannedQty,
    required this.actualQty,
    required this.isActive,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    // required this.varianceLogs,
  });

  factory PlanUpdate.fromJson(Map<String, dynamic> json) {
    return PlanUpdate(
      id: json['id'],
      weekPlanId: json['week_plan_id'],
      categoryId: json['category_id'],
      weekDay: json['week_day'],
      weekDate: json['week_date'],
      activityId: json['activity_id'],
      uomId: json['uom_id'],
      activityOther: json['activity_other']??" " ,
      plannedQty: json['planned_qty'],
      actualQty: json['actual_qty'],
      isActive: json['is_active'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      // varianceLogs: (json['variance_logs'] as List)
      //     .map((v) => PlanVarianceLog.fromJson(v))
      //     .toList(),
    );
  }
}

class PlanVarianceLog {
  final int id;
  final int weekActivityId;
  final int projLocId;
  final int varianceId;
  final String description;
  final int status;
  final String? remark;
  final String createdAt;
  final String updatedAt;

  PlanVarianceLog({
    required this.id,
    required this.weekActivityId,
    required this.projLocId,
    required this.varianceId,
    required this.description,
    required this.status,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlanVarianceLog.fromJson(Map<String, dynamic> json) {
    return PlanVarianceLog(
      id: json['id'],
      weekActivityId: json['week_activity_id'],
      projLocId: json['proj_loc_id'],
      varianceId: json['variance_id'],
      description: json['description']?? " ",
      status: json['status'],
      remark: json['remark'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
