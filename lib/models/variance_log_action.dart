

class VarianceLogAction {
  final int id;
  final int weekActivityId;
  final int projLocId;
  final int varianceId;
  final String description;
  final String action;
  final int status;
  final String? remark;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Variance variance;
  final ProjectLocation projectLocation;

  VarianceLogAction({
    required this.id,
    required this.weekActivityId,
    required this.projLocId,
    required this.varianceId,
    required this.description,
    required this.action,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.variance,
    required this.projectLocation,
  });

  factory VarianceLogAction.fromJson(Map<String, dynamic> json) {
    return VarianceLogAction(
      id: json['id'],
      weekActivityId: json['week_activity_id'],
      projLocId: json['proj_loc_id'],
      varianceId: json['variance_id'],
      description: json['description']??'',
      action: json['action'],
      status: json['status'],
      remark: json['remark'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      variance: Variance.fromJson(json['variance']),
      projectLocation: ProjectLocation.fromJson(json['project_locations']),
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
