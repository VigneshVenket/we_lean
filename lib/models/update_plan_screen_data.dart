

// class UpdatePlanScreenActivity {
//   final int id;
//   final int weekPlanId;
//   final int categoryId;
//   final int weekDay;
//   final String weekDate;
//   final int activityId;
//   final int uomId;
//   final dynamic activityOther;
//   final int plannedQty;
//   final int actualQty;
//   final int isActive;
//   final int status;
//   final String createdAt;
//   final String updatedAt;
//   final UpdatedActivity activity;
//
//   UpdatePlanScreenActivity({
//     required this.id,
//     required this.weekPlanId,
//     required this.categoryId,
//     required this.weekDay,
//     required this.weekDate,
//     required this.activityId,
//     required this.uomId,
//     required this.activityOther,
//     required this.plannedQty,
//     required this.actualQty,
//     required this.isActive,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.activity,
//   });
//
//   factory UpdatePlanScreenActivity.fromJson(Map<String, dynamic> json) {
//     return UpdatePlanScreenActivity(
//       id: json['id'] ?? 0,
//       weekPlanId: json['week_plan_id'] ?? 0,
//       categoryId: json['category_id'] ?? 0,
//       weekDay: json['week_day'] ?? 0,
//       weekDate: json['week_date'] ?? "",
//       activityId: json['activity_id'] ?? 0,
//       uomId: json['uom_id'] ?? 0,
//       activityOther: json['activity_other'],
//       plannedQty: json['planned_qty'] ?? 0,
//       actualQty: json['actual_qty'] ?? 0,
//       isActive: json['is_active'] ?? 0,
//       status: json['status'] ?? 0,
//       createdAt: json['created_at'] ?? "",
//       updatedAt: json['updated_at'] ?? "",
//       activity: UpdatedActivity.fromJson(json['activity'] ?? {}),
//     );
//   }
// }
//
// // Model class for an updated activity in the update plan screen
// class UpdatedActivity {
//   final int id;
//   final String name;
//   final String description;
//   final String createdAt;
//   final String updatedAt;
//
//   UpdatedActivity({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory UpdatedActivity.fromJson(Map<String, dynamic> json) {
//     return UpdatedActivity(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? "",
//       description: json['description'] ?? "",
//       createdAt: json['created_at'] ?? "",
//       updatedAt: json['updated_at'] ?? "",
//     );
//   }
// }


class UpdatePlanScreenActivity {
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
  final UpdatedActivity activity;
  final VarianceLog varianceLogs;

  UpdatePlanScreenActivity({
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
    required this.varianceLogs,
  });

  factory UpdatePlanScreenActivity.fromJson(Map<String, dynamic> json) {
    return UpdatePlanScreenActivity(
      id: json['id'] ?? 0,
      weekPlanId: json['week_plan_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      weekDay: json['week_day'] ?? 0,
      weekDate: json['week_date'] ?? "",
      activityId: json['activity_id'] ?? 0,
      uomId: json['uom_id'] ?? 0,
      activityOther: json['activity_other'],
      plannedQty: json['planned_qty'] ?? 0,
      actualQty: json['actual_qty'] ?? 0,
      isActive: json['is_active'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      activity: UpdatedActivity.fromJson(json['activity'] ?? {}),
      varianceLogs: VarianceLog.fromJson(json['variance_logs'] ?? {})
    );
  }
}

class UpdatedActivity {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  UpdatedActivity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdatedActivity.fromJson(Map<String, dynamic> json) {
    return UpdatedActivity(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}

class VarianceLog {
  final int id;
  final int weekActivityId;
  final int projLocId;
  final int varianceId;
  final String description;
  final String? why1;
  final String? why2;
  final String? why3;
  final String? why4;
  final String? why5;
  final String? action;
  final int status;
  final String? remark;
  final String createdAt;
  final String updatedAt;
  final Variance variance;

  VarianceLog({
    required this.id,
    required this.weekActivityId,
    required this.projLocId,
    required this.varianceId,
    required this.description,
    this.why1,
    this.why2,
    this.why3,
    this.why4,
    this.why5,
    this.action,
    required this.status,
    this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.variance,
  });

  factory VarianceLog.fromJson(Map<String, dynamic> json) {
    return VarianceLog(
      id: json['id'] ?? 0,
      weekActivityId: json['week_activity_id'] ?? 0,
      projLocId: json['proj_loc_id'] ?? 0,
      varianceId: json['variance_id'] ?? 0,
      description: json['description'] ?? "",
      why1: json['why1'],
      why2: json['why2'],
      why3: json['why3'],
      why4: json['why4'],
      why5: json['why5'],
      action: json['action'],
      status: json['status'] ?? 0,
      remark: json['remark'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      variance: Variance.fromJson(json['variance'] ?? {}),
    );
  }
}

class Variance {
  final int id;
  final String name;
  final String description;
  final String groupId;
  final String createdAt;
  final String updatedAt;
  final Group group;

  Variance({
    required this.id,
    required this.name,
    required this.description,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.group,
  });

  factory Variance.fromJson(Map<String, dynamic> json) {
    return Variance(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      groupId: json['group_id'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      group: Group.fromJson(json['group'] ?? {}),
    );
  }
}

class Group {
  final int id;
  final String groupName;
  final String roleId;
  final String rolesName;
  final String createdAt;
  final String updatedAt;

  Group({
    required this.id,
    required this.groupName,
    required this.roleId,
    required this.rolesName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] ?? 0,
      groupName: json['group_name'] ?? "",
      roleId: json['role_id'] ?? "",
      rolesName: json['roles_name'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
