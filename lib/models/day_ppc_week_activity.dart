

class DayPpcWeekActivity {
  final int id;
  final int weekPlanId;
  final int categoryId;
  final int weekDay;
  final String weekDate;
  final int activityId;
  final int uomId;
  final dynamic activityOther;
  final int plannedQty;
  final int actualQty;
  final int isActive;
  final int status;
  final String createdAt;
  final String updatedAt;
  final DayPpcActivity activity;

  DayPpcWeekActivity({
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
    required this.activity,
  });

  factory DayPpcWeekActivity.fromJson(Map<String, dynamic> json) {
    return DayPpcWeekActivity(
      id: json['id'],
      weekPlanId: json['week_plan_id'],
      categoryId: json['category_id'],
      weekDay: json['week_day'],
      weekDate: json['week_date'],
      activityId: json['activity_id'],
      uomId: json['uom_id'],
      activityOther: json['activity_other'],
      plannedQty: json['planned_qty'],
      actualQty: json['actual_qty'],
      isActive: json['is_active'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      activity: DayPpcActivity.fromJson(json['activity']),
    );
  }
}

class DayPpcActivity {
  final int id;
  final String name;

  DayPpcActivity({
    required this.id,
    required this.name,
  });

  factory DayPpcActivity.fromJson(Map<String, dynamic> json) {
    return DayPpcActivity(
      id: json['id'],
      name: json['name'],
    );
  }
}
