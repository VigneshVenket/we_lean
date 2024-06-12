



class TodayPlan {
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
  final Activity activity;
  final Uom uom;

  TodayPlan({
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
    required this.uom
  });

  factory TodayPlan.fromJson(Map<String, dynamic> json) {
    return TodayPlan(
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
      activity: Activity.fromJson(json['activity']),
      uom: Uom.fromJson(json['uom'])
    );
  }
}

class Activity {
  final int id;
  final String name;
  final String activityImage;
  final String description;
  final String createdAt;
  final String updatedAt;

  Activity({
    required this.id,
    required this.name,
    required this.activityImage,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      activityImage: json['activity_image'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


class Uom {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  Uom({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Uom.fromJson(Map<String, dynamic> json) {
    return Uom(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}


