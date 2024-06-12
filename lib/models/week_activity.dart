
class WeekActivity {
  final int categoryId;
  final int weekDay;
  final int plannedQty;
  final int activityId;
  final String constraintId;
  final String? weekDate;
  final int? uomId;
  final String description;
  final String clearanceBeforeDt="25-05-24";
  final String ?category;
  final String ?activity;
  final String ?uom;
  final String ?constraint;
  final String ?day;

  WeekActivity({
    required this.categoryId,
    required this.weekDay,
    required this.plannedQty,
    required this.activityId,
    required this.constraintId,
    required this.weekDate,
    required this.uomId,
    required this.description,
    this.activity,
    this.category,
    this.uom,
    this.constraint,
    this.day
  });


  factory WeekActivity.fromJson(Map<String, dynamic> json) {
    return WeekActivity(
      categoryId: json['category_id'],
      weekDay: json['week_day'],
      plannedQty: json['planned_qty'],
      activityId: json['activity_id'],
      constraintId: json['constraint_id'],
      weekDate: json['week_date'],
      uomId: json['uom_id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'week_day': weekDay,
      'planned_qty': plannedQty,
      'activity_id': activityId,
      'constraint_id': constraintId,
      'week_date': weekDate,
      'uom_id': uomId,
      'description': description,
      'clearance_before_dt': clearanceBeforeDt,
    };
  }
}

// Define a WeekPlan class to represent the entire week plan
class WeekPlan {
  final int userId;
  final WeekActivity weekActivity;

  WeekPlan({
    required this.userId,
    required this.weekActivity,
  });

  // Factory method to create WeekPlan object from JSON
  factory WeekPlan.fromJson(Map<String, dynamic> json) {
    // List<dynamic weekActivityJson = json['WeekActivity'];
    // List<WeekActivity> weekActivityList = weekActivityJson.map((activity) => WeekActivity.fromJson(activity)).toList();

    return WeekPlan(
      userId: json['user_id'],
      weekActivity:json['WeekActivity'],
    );
  }

  Map<String, dynamic> toJson() {

    // List<Map<String, dynamic>> weekActivityJson = weekActivity.map((activity) => activity.toJson()).toList();
    return {
      'user_id': userId,
      'WeekActivity': weekActivity,
    };
  }
}
