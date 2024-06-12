


class RootCause {
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
  String? action;
  int? status;
  dynamic remark;
  String? createdAt;
  String? updatedAt;
  Variance? variance;
  ProjectLocation? projectLocation;

  RootCause({
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
    this.action,
    this.status,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.variance,
    this.projectLocation,
  });

  RootCause.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekActivityId = json['week_activity_id'];
    projLocId = json['proj_loc_id'];
    varianceId = json['variance_id'];
    description = json['description'];
    why1 = json['why1'];
    why2 = json['why2'];
    why3 = json['why3'];
    why4 = json['why4'];
    why5 = json['why5'];
    action = json['action'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variance = json['variance'] != null ? Variance.fromJson(json['variance']) : null;
    projectLocation = json['project_locations'] != null ? ProjectLocation.fromJson(json['project_locations']) : null;
  }
}

class Variance {
  int? id;
  String? name;

  Variance({this.id, this.name});

  Variance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class ProjectLocation {
  int? id;
  String? description;

  ProjectLocation({this.id, this.description});

  ProjectLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }
}
