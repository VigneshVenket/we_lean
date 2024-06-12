
class UserLocationPlan {
  final int id;
  final int userId;
  final int weekNumber;
  final int projLocId;
  final String dateSubmitted;
  final String dateRange;
  final String ?approvalStatus;
  final int? approvedBy;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final ProjectLocation projectLocation;

  UserLocationPlan({
    required this.id,
    required this.userId,
    required this.weekNumber,
    required this.projLocId,
    required this.dateSubmitted,
    required this.dateRange,
    required this.approvalStatus,
    this.approvedBy,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.projectLocation,
  });

  factory UserLocationPlan.fromJson(Map<String, dynamic> json) {
    return UserLocationPlan(
      id: json['id'],
      userId: json['user_id'],
      weekNumber: json['week_number'],
      projLocId: json['proj_loc_id'],
      dateSubmitted: json['date_submitted'],
      dateRange: json['date_range'],
      approvalStatus: json['approval_status'],
      approvedBy: json['approved_by'],
      isActive: json['is_active'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      projectLocation: ProjectLocation.fromJson(json['project_location']),
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
