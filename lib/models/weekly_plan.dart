

class WeeklyPlan {
  final int id;
  final int userId;
  final int weekNumber;
  final int projLocId;
  final String dateSubmitted;
  final String dateRange;
  final String approvalStatus;
  final dynamic approvedBy;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  final List<WeekActivity> weekActivities;

  WeeklyPlan({
    required this.id,
    required this.userId,
    required this.weekNumber,
    required this.projLocId,
    required this.dateSubmitted,
    required this.dateRange,
    required this.approvalStatus,
    required this.approvedBy,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.weekActivities,
  });

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) {
    return WeeklyPlan(
      id: json['id'],
      userId: json['user_id'],
      weekNumber: json['week_number'],
      projLocId: json['proj_loc_id'],
      dateSubmitted: json['date_submitted'],
      dateRange: json['date_range'],
      approvalStatus: json['approval_status'],
      approvedBy: json['approved_by'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      weekActivities: List<WeekActivity>.from(json['week_activities'].map((x) => WeekActivity.fromJson(x))),
    );
  }
}

class WeekActivity {
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
  final dynamic status;
  final String createdAt;
  final String updatedAt;
  final Activity activity;
  final Uom uom;
  final Category category;
  final List<ConstraintLog> constraintLogs;

  WeekActivity({
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
    required this.uom,
    required this.category,
    required this.constraintLogs,
  });

  factory WeekActivity.fromJson(Map<String, dynamic> json) {
    return WeekActivity(
      id: json['id'] ?? 0, // Provide a default value if null
      weekPlanId: json['week_plan_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      weekDay: json['week_day'] ?? 0,
      weekDate: json['week_date'] ?? '', // Provide an empty string if null
      activityId: json['activity_id'] ?? 0,
      uomId: json['uom_id'] ?? 0,
      activityOther: json['activity_other'],
      plannedQty: json['planned_qty'] ?? 0,
      actualQty: json['actual_qty'] ?? 0,
      isActive: json['is_active'] ?? 0,
      status: json['status'],
      createdAt: json['created_at'] ?? '', // Provide an empty string if null
      updatedAt: json['updated_at'] ?? '', // Provide an empty string if null
      activity: Activity.fromJson(json['activity']),
      uom: Uom.fromJson(json['uom']),
      category: Category.fromJson(json['category']),
      constraintLogs: json['constraint_logs'] != null
          ? List<ConstraintLog>.from(json['constraint_logs'].map((x) => ConstraintLog.fromJson(x)))
          : [],
    );
  }
}

class Activity {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
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

class Category {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ConstraintLog {
  final int id;
  final int weekActivityId;
  final int categoryId;
  final int projLocId;
  final String constraintId;
  final dynamic description;
  final String identifiedOnDt;
  final String clearanceBeforeDt;
  final dynamic actualClearanceDt;
  final int status;
  final dynamic remark;
  final String createdAt;
  final String updatedAt;
  final ProjectLocation projectLocation;
  final Constraint constraint;

  ConstraintLog({
    required this.id,
    required this.weekActivityId,
    required this.categoryId,
    required this.projLocId,
    required this.constraintId,
    required this.description,
    required this.identifiedOnDt,
    required this.clearanceBeforeDt,
    required this.actualClearanceDt,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.projectLocation,
    required this.constraint,
  });

  factory ConstraintLog.fromJson(Map<String, dynamic> json) {
    return ConstraintLog(
      id: json['id'] ?? 0,
      weekActivityId: json['week_activity_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      projLocId: json['proj_loc_id'] ?? 0,
      constraintId: json['constraint_id'] ?? '',
      description: json['description'],
      identifiedOnDt: json['identified_on_dt'] ?? '', // Provide an empty string if null
      clearanceBeforeDt: json['clearance_before_dt'] ?? '', // Provide an empty string if null
      actualClearanceDt: json['actual_clearance_dt'],
      status: json['status'] ?? 0,
      remark: json['remark'],
      createdAt: json['created_at'] ?? '', // Provide an empty string if null
      updatedAt: json['updated_at'] ?? '', // Provide an empty string if null
      projectLocation: json['project_location'] != null ? ProjectLocation.fromJson(json['project_location']) : ProjectLocation(id: 0, locationId: 0, projectId: 0, description: '', createdAt: '', updatedAt: ''),
      constraint: json['constraint'] != null ? Constraint.fromJson(json['constraint']) : Constraint(id: 0, name: '', projectId: 0, groupId: '', responsibleRole: null, description: '', createdAt: '', updatedAt: ''),
    );
  }

}

class ProjectLocation {
  final int id;
  final int locationId;
  final int projectId;
  final String description;
  final String createdAt;
  final String updatedAt;

  ProjectLocation({
    required this.id,
    required this.locationId,
    required this.projectId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectLocation.fromJson(Map<String, dynamic> json) {
    return ProjectLocation(
      id: json['id'],
      locationId: json['location_id'],
      projectId: json['project_id'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Constraint {
  final int id;
  final String name;
  final dynamic projectId;
  final String groupId;
  final dynamic responsibleRole;
  final String description;
  final String createdAt;
  final String updatedAt;

  Constraint({
    required this.id,
    required this.name,
    required this.projectId,
    required this.groupId,
    required this.responsibleRole,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Constraint.fromJson(Map<String, dynamic> json) {
    return Constraint(
      id: json['id'],
      name: json['name'],
      projectId: json['project_id'],
      groupId: json['group_id'],
      responsibleRole: json['responsible_role'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
