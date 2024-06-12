

class CurrentWeekPlanActivity {
  final int id;
  final int userId;
  final int weekNumber;
  final int projectLocationId;
  final String dateSubmitted;
  final String dateRange;
  final String approvalStatus;
  final int approvedBy;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectLocation projectLocation;
  final Map<int, List<WeekActivity>> weekActivities;  // Changed to Map

  CurrentWeekPlanActivity({
    required this.id,
    required this.userId,
    required this.weekNumber,
    required this.projectLocationId,
    required this.dateSubmitted,
    required this.dateRange,
    required this.approvalStatus,
    required this.approvedBy,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.projectLocation,
    required this.weekActivities,
  });

  factory CurrentWeekPlanActivity.fromJson(Map<String, dynamic> json) {
    return CurrentWeekPlanActivity(
      id: json['id'],
      userId: json['user_id'],
      weekNumber: json['week_number'],
      projectLocationId: json['proj_loc_id'],
      dateSubmitted: json['date_submitted'],
      dateRange: json['date_range'],
      approvalStatus: json['approval_status'],
      approvedBy: json['approved_by'] ?? 0,
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      projectLocation: ProjectLocation.fromJson(json['project_location']),
      weekActivities: (json['week_activities'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(int.parse(k), List<WeekActivity>.from(v.map((x) => WeekActivity.fromJson(x)))),
      ),
    );
  }
}


// Model class for project location
class ProjectLocation {
  final int id;
  final int locationId;
  final int projectId;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Model class for week activity
class WeekActivity {
  final int id;
  final int weekPlanId;
  final int categoryId;
  final int weekDay;
  final String weekDate;
  final int activityId;
  final int uomId;
  final String? activityOther;
  final int plannedQty;
  final int actualQty;
  final int isActive;
  final dynamic status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Activity activity;
  final UnitOfMeasurement uom;
  final Category category;

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
  });

  factory WeekActivity.fromJson(Map<String, dynamic> json) {
    return WeekActivity(
      id: json['id'],
      weekPlanId: json['week_plan_id'],
      categoryId: json['category_id'],
      weekDay: json['week_day'],
      weekDate: json['week_date'],
      activityId: json['activity_id'],
      uomId: json['uom_id'],
      activityOther: json['activity_other'],
      plannedQty: json['planned_qty'],
      actualQty: json['actual_qty']??0,
      isActive: json['is_active'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      activity: Activity.fromJson(json['activity']),
      uom: UnitOfMeasurement.fromJson(json['uom']),
      category: Category.fromJson(json['category']),
    );
  }
}

// Model class for activity

class Activity {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Model class for unit of measurement
class UnitOfMeasurement {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  UnitOfMeasurement({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnitOfMeasurement.fromJson(Map<String, dynamic> json) {
    return UnitOfMeasurement(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Model class for category
class Category {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}


// class WeekActivity {
//   final int id;
//   final int weekPlanId;
//   final int categoryId;
//   final int weekDay;
//   final String weekDate;
//   final int activityId;
//   final int uomId;
//   final String? activityOther;
//   final int plannedQty;
//   final int actualQty;
//   final int isActive;
//   final dynamic status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Activity activity;
//   final UnitOfMeasurement uom;
//   final Category category;
//
//   WeekActivity({
//     required this.id,
//     required this.weekPlanId,
//     required this.categoryId,
//     required this.weekDay,
//     required this.weekDate,
//     required this.activityId,
//     required this.uomId,
//     this.activityOther,
//     required this.plannedQty,
//     required this.actualQty,
//     required this.isActive,
//     this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.activity,
//     required this.uom,
//     required this.category,
//   });
//
//   factory WeekActivity.fromJson(Map<String, dynamic> json) {
//     return WeekActivity(
//       id: json['id'],
//       weekPlanId: json['week_plan_id'],
//       categoryId: json['category_id'],
//       weekDay: json['week_day'],
//       weekDate: json['week_date'],
//       activityId: json['activity_id'],
//       uomId: json['uom_id'],
//       activityOther: json['activity_other'],
//       plannedQty: json['planned_qty'],
//       actualQty: json['actual_qty'] ?? 0,
//       isActive: json['is_active'],
//       status: json['status'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       activity: Activity.fromJson(json['activity']),
//       uom: UnitOfMeasurement.fromJson(json['uom']),
//       category: Category.fromJson(json['category']),
//     );
//   }
// }
//
// // Model class for activities
// class Activity {
//   final int id;
//   final String name;
//   final String description;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Activity({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Activity.fromJson(Map<String, dynamic> json) {
//     return Activity(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }
//
// // Model class for units of measurement
// class UnitOfMeasurement {
//   final int id;
//   final String name;
//   final String description;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   UnitOfMeasurement({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory UnitOfMeasurement.fromJson(Map<String, dynamic> json) {
//     return UnitOfMeasurement(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }
//
// // Model class for categories
// class Category {
//   final int id;
//   final String name;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['name'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
// }