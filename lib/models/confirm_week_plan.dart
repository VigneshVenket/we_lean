
class ConfirmWeekPlan {
  final int id;
  final int userId;
  final int weekNumber;
  final int projLocId;
  final String dateSubmitted;
  final String dateRange;
  final String approvalStatus;
  final int approvedBy;
  final int isActive;
  final int isSubmit;
  final String createdAt;
  final String updatedAt;

  ConfirmWeekPlan({
    required this.id,
    required this.userId,
    required this.weekNumber,
    required this.projLocId,
    required this.dateSubmitted,
    required this.dateRange,
    required this.approvalStatus,
    required this.approvedBy,
    required this.isActive,
    required this.isSubmit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConfirmWeekPlan.fromJson(Map<String, dynamic> json) {
    return ConfirmWeekPlan(
      id: json['id'],
      userId: json['user_id'],
      weekNumber: json['week_number'],
      projLocId: json['proj_loc_id'],
      dateSubmitted: json['date_submitted'],
      dateRange: json['date_range'],
      approvalStatus: json['approval_status'],
      approvedBy: json['approved_by'],
      isActive: json['is_active'],
      isSubmit: json['is_submit'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
