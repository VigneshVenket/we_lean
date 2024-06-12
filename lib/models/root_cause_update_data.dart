


class RootCauseUpdateData {
  final int id;
  final int weekActivityId;
  final int projLocId;
  final int varianceId;
  final String description;
  final String why1;
  final String why2;
  final String why3;
  final String why4;
  final String why5;
  final String? action;
  final int status;
  final String? remark;
  final String createdAt;
  final String updatedAt;
  final Variance variance;
  final ProjectLocation projectLocations;

  RootCauseUpdateData({
    required this.id,
    required this.weekActivityId,
    required this.projLocId,
    required this.varianceId,
    required this.description,
    required this.why1,
    required this.why2,
    required this.why3,
    required this.why4,
    required this.why5,
    required this.action,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.variance,
    required this.projectLocations,
  });

  factory RootCauseUpdateData.fromJson(Map<String, dynamic> json) {
    return RootCauseUpdateData(
      id: json['id'],
      weekActivityId: json['week_activity_id'],
      projLocId: json['proj_loc_id'],
      varianceId: json['variance_id'],
      description: json['description']??" ",
      why1: json['why1'],
      why2: json['why2'],
      why3: json['why3'],
      why4: json['why4'],
      why5: json['why5'],
      action: json['action']??" ",
      status: json['status'],
      remark: json['remark'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      variance: Variance.fromJson(json['variance']),
      projectLocations: ProjectLocation.fromJson(json['project_locations']),
    );
  }
}

class Variance {
  final int id;
  final String name;

  Variance({
    required this.id,
    required this.name,
  });

  factory Variance.fromJson(Map<String, dynamic> json) {
    return Variance(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProjectLocation {
  final int id;
  final String description;

  ProjectLocation({
    required this.id,
    required this.description,
  });

  factory ProjectLocation.fromJson(Map<String, dynamic> json) {
    return ProjectLocation(
      id: json['id'],
      description: json['description'],
    );
  }
}