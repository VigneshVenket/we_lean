
class LineChartVarianceData {
  int? id;
  int? weekActivityId;
  int? projLocId;
  int? varianceId;
  String? description;
  String? why1;
  String? why2;
  String? why3;
  String? why4;
  String? why5;
  String? group_id_1;
  String? group_id_2;
  String? group_id_3;
  String? group_id_4;
  String? group_id_5;
  String? action;
  int? status;
  dynamic remark;
  String? createdAt;
  String? updatedAt;
  LineChartVariance? variance;
  LineChartProjectLocation? projectLocation;
  LineChartWeekActivity? weekActivity;



  LineChartVarianceData({
    this.id,
    this.weekActivityId,
    this.projLocId,
    this.varianceId,
    this.description,
    this.why1,
    this.why2,
    this.why3,
    this.why4,
    this.why5,
    this.group_id_1,
    this.group_id_2,
    this.group_id_3,
    this.group_id_4,
    this.group_id_5,
    this.action,
    this.status,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.variance,
    this.projectLocation,
    this.weekActivity,
    // Initialize why groups
  });

  LineChartVarianceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekActivityId = json['week_activity_id'];
    projLocId = json['proj_loc_id'];
    varianceId = json['variance_id'];
    description = json['description'];
    why1=json['why1'];
    why2=json['why2'];
    why3=json['why3'];
    why4=json['why4'];
    why5=json['why5'];
    action = json['action'] as String?;

    // final dynamic actionValue = json['action'];
    // if (actionValue is String) {
    //   action = actionValue;
    // } else {
    //   // Handle the case where 'action' is not a string, such as assigning a default value or logging an error.
    //   action = null; // Or assign a default value like "Unknown"
    //   print('Warning: Unexpected type for "action" field: $actionValue');
    // }
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variance = LineChartVariance.fromJson(json['variance']);
    projectLocation = LineChartProjectLocation.fromJson(json['project_locations']);
    weekActivity = LineChartWeekActivity.fromJson(json['week_activities']); // Update here

    print(json['why_groups']);
  }
}


class LineChartWeekActivity {
  int? id;
  int? weekPlanId;
  int? categoryId;
  int? weekDay;
  String? weekDate;
  int? activityId;
  int? uomId;
  dynamic? activityOther;
  int? plannedQty;
  int? actualQty;
  int? isActive;
  int? status;
  String? createdAt;
  String? updatedAt;
  LineChartActivity ?lineChartActivity;

  LineChartWeekActivity({
    this.id,
    this.weekPlanId,
    this.categoryId,
    this.weekDay,
    this.weekDate,
    this.activityId,
    this.uomId,
    this.activityOther,
    this.plannedQty,
    this.actualQty,
    this.isActive,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lineChartActivity
  });

  LineChartWeekActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekPlanId = json['week_plan_id'];
    categoryId = json['category_id'];
    weekDay = json['week_day'];
    weekDate = json['week_date'];
    activityId = json['activity_id'];
    uomId = json['uom_id'];
    activityOther = json['activity_other'];
    plannedQty = json['planned_qty'];
    actualQty = json['actual_qty'];
    isActive = json['is_active'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lineChartActivity=LineChartActivity.fromJson(json['activity']);
  }
}

class LineChartActivity {
  int? id;
  String? name;

  LineChartActivity({
    this.id,
    this.name,
  });

  LineChartActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}


class LineChartVariance {
  int ?id;
  String ?name;

  LineChartVariance({this.id, this.name});

  LineChartVariance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class LineChartProjectLocation {
  int ?id;
  String ?description;

  LineChartProjectLocation({this.id, this.description});

  LineChartProjectLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }
}
