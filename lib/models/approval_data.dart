

class ApprovalData {
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

  ApprovalData({
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
  });

  factory ApprovalData.fromJson(Map<String, dynamic> json) {
    return ApprovalData(
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