import 'package:we_lean/utils/app_constants.dart';

// class WeekPlanResponse {
//    String ?status;
//    String ?message;
//    WeekPlanData ?data;
//    int ?code;
//
//   WeekPlanResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//     required this.code,
//   });
//
//    factory WeekPlanResponse.fromJson(Map<String, dynamic> json) {
//      Map<String, dynamic>? jsonData = json['data'];
//      WeekPlanData? weekPlanData;
//
//      if (jsonData != null) {
//        weekPlanData = WeekPlanData.fromJson(jsonData);
//      }
//
//      return WeekPlanResponse(
//        status: json['status'],
//        message: json['message'],
//        data: weekPlanData,
//        code: json['code'],
//      );
//    }
//
//
//    WeekPlanResponse.withError(String error) {
//      status = AppConstants.status_error;
//      message = error;
//      data = null;
//      code = 0;
//    }
// }
//
// class WeekPlanData {
//   final int id;
//   final int userId;
//   final int weekNumber;
//   final int projLocId;
//   final String dateSubmitted;
//   final String dateRange;
//   final String approvalStatus;
//   final dynamic approvedBy;
//   final int isActive;
//   final String createdAt;
//   final String updatedAt;
//
//   WeekPlanData({
//     required this.id,
//     required this.userId,
//     required this.weekNumber,
//     required this.projLocId,
//     required this.dateSubmitted,
//     required this.dateRange,
//     required this.approvalStatus,
//     required this.approvedBy,
//     required this.isActive,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory WeekPlanData.fromJson(Map<String, dynamic> json) {
//     return WeekPlanData(
//       id: json['id'],
//       userId: json['user_id'],
//       weekNumber: json['week_number'],
//       projLocId: json['proj_loc_id'],
//       dateSubmitted: json['date_submitted'],
//       dateRange: json['date_range'],
//       approvalStatus: json['approval_status'],
//       approvedBy: json['approved_by'],
//       isActive: json['is_active'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
// }


class WeekPlanResponse {
  final String? status;
  final String? message;
  final WeekPlanData? data;
  final int? code;

  WeekPlanResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.code,
  });

  factory WeekPlanResponse.fromJson(Map<String, dynamic> json) {
    return WeekPlanResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? WeekPlanData.fromJson(json['data']) : null,
      code: json['code'],
    );
  }

  WeekPlanResponse.withError(String error)
      : status = 'error',
        message = error,
        data = null,
        code = 0;
}

class WeekPlanData {
  final int id;
  final int userId;
  final int weekNumber;
  final int projLocId;
  final String dateSubmitted;
  final String dateRange;
  final String approvalStatus;
  final int? approvedBy;
  final int isActive;
  final int isSubmit; // This field was missing in your original model
  final String createdAt;
  final String updatedAt;

  WeekPlanData({
    required this.id,
    required this.userId,
    required this.weekNumber,
    required this.projLocId,
    required this.dateSubmitted,
    required this.dateRange,
    required this.approvalStatus,
    required this.approvedBy,
    required this.isActive,
    required this.isSubmit, // This field was missing in your original model
    required this.createdAt,
    required this.updatedAt,
  });

  factory WeekPlanData.fromJson(Map<String, dynamic> json) {
    return WeekPlanData(
      id: json['id'],
      userId: json['user_id'],
      weekNumber: json['week_number'],
      projLocId: json['proj_loc_id'],
      dateSubmitted: json['date_submitted'],
      dateRange: json['date_range'],
      approvalStatus: json['approval_status'],
      approvedBy: json['approved_by'],
      isActive: json['is_active'],
      isSubmit: json['is_submit'], // This field was missing in your original model
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

